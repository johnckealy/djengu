
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/ubuntu-20.04"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network", ip: "192.168.33.121", type: "dhcp", bridge: "wlp2s0"

  config.vm.provision "file", source: "/home/jokea/code/digitalocean/initial_setup.sh", destination: "~/initial_setup.sh"
  config.vm.provision "file", source: "/home/jokea/code/caddy/", destination: "~/caddy/"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    mv /home/vagrant/initial_setup.sh /root/
    mv /home/vagrant/caddy/ /
    mkdir /root/.ssh/
    touch /root/.ssh/authorized_keys
  SHELL
end
