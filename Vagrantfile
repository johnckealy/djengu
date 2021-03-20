
Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-20.04"

  config.vm.network "public_network", type: "dhcp", bridge: "wlp2s0" #, ip: "192.168.33.121",

  config.vm.provision "file", source: "./.production_toolbox/server_setup.sh", destination: "/home/vagrant/server_setup.sh"
  config.vm.provision "file", source: "./.production_toolbox/caddy", destination: "/home/vagrant/"

  config.vm.provision "shell", inline: <<-SHELL
    # mv /home/vagrant/server_setup.sh /root/
    mv /home/vagrant/caddy/ /
    mkdir /root/.ssh/
    touch /root/.ssh/authorized_keys
    cd /caddy/ && docker-compose -f docker-compose.caddy.yml up --build -d
  SHELL
end
