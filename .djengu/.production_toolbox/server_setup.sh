#!/bin/bash
set -euo pipefail
########################
### SCRIPT VARIABLES ###
########################


USERNAME=jokea


COPY_AUTHORIZED_KEYS_FROM_ROOT=true
####################
### SCRIPT LOGIC ###
####################
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"
encrypted_root_pw="$(grep root /etc/shadow | cut --delimiter=: --fields=2)"
if [ "${encrypted_root_pw}" != "*" ]; then
    echo "${USERNAME}:${encrypted_root_pw}" | chpasswd --encrypted
    passwd --lock root
else
    passwd --delete "${USERNAME}"
fi
chage --lastday 0 "${USERNAME}"
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"
if [ "${COPY_AUTHORIZED_KEYS_FROM_ROOT}" = true ]; then
    cp /root/.ssh/authorized_keys "${home_directory}/.ssh"
fi
for pub_key in "${OTHER_PUBLIC_KEYS_TO_ADD[@]}"; do
    echo "${pub_key}" >> "${home_directory}/.ssh/authorized_keys"
done
chmod 0700 "${home_directory}/.ssh"
chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh"
sed --in-place 's/^PermitRootLogin.*/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
if sshd -t -q; then
    systemctl restart sshd
fi
ufw allow OpenSSH
ufw --force enable

################### Basic tools ################
apt-get update -y
apt-get install build-essential nodejs npm net-tools -y
apt-get install gnupg2 -y
npm install -g @quasar/cli



#################### Docker ####################
apt-get update -y &&
apt-get install apt-transport-https ca-certificates curl software-properties-common gnupg-agent -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io -y
apt-cache policy docker-ce
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# groupadd docker
usermod -aG docker ${USERNAME}



###################### bashrc  #############################
echo '
alias gst="git status"
alias gl="git log"

alias venv="source ${PWD}/.*/bin/activate"

# function to nuke everything in docker
docker-armageddon() {
    docker-compose down -v
    docker-compose -f docker-compose.prod.yml down -v
    docker stop -f $(docker ps -a -q)
    docker rm -f $(docker ps -a -q)
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}
' >> /home/"${USERNAME}"/.bashrc


ssh-keygen -t rsa -b 4096 -m PEM -q -N "" -f /home/"${USERNAME}"/.ssh/id_rsa
# Now add the keys to github (if necessary)
# These commands must be separate
cat /home/"${USERNAME}"/.ssh/id_rsa.pub >>  /home/"${USERNAME}"/.ssh/authorized_keys
chown -R "${USERNAME}":"${USERNAME}" /home/"${USERNAME}"/.ssh


########## Remember to declare the EXTERNAL NETWORK for Docker! #############
docker network create caddyweb



############## And finally... ###############
echo "Running system upgrades../"
DEBIAN_FRONTEND=noninteractive
apt-get update -y
yes | apt-get upgrade -y

echo "Done. Rebooting..."
reboot