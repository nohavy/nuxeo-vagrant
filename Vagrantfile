# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
MACHINE_LOCAL_IP_ADDRESS = "192.168.68.10"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "bento/ubuntu-20.04" # bento is recomended by vagrant docs https://app.vagrantup.com/bento/boxes/ubuntu-20.04
  config.vm.network "private_network", ip: MACHINE_LOCAL_IP_ADDRESS
  config.ssh.host = MACHINE_LOCAL_IP_ADDRESS

  
  # set correct timezone
  require 'time'
  timezone = 'Europe/Lisbon'
  config.vm.provision :shell, :inline => "if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo \"#{timezone}\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi"
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # config.vm.define "nuxeo" do |nuxeo|
  #   nuxeo.vm.network "private_network", ip: "192.168.100.10"
  # end

  config.vm.provision "shell", path: "scripts/provision.sh"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 80, host: 9090

end
