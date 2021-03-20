
Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-20.04"

  config.vm.network "public_network", ip: "192.168.33.121", type: "dhcp", bridge: "wlp2s0"

  config.vm.provision "file", source: "./.production/initial_setup.sh", destination: "~/initial_setup.sh"
  config.vm.provision "file", source: "./.production/caddy", destination: "~/caddy/"

  config.vm.provision "shell", inline: <<-SHELL
    mv /home/vagrant/initial_setup.sh /root/
    mv /home/vagrant/caddy/ /
    mkdir /root/.ssh/
    touch /root/.ssh/authorized_keys
  SHELL
end
