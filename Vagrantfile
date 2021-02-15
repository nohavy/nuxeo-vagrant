# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
TIME_ZONE = "Europe/Lisbon"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "bento/debian-10" # bento is recomended by vagrant docs

  # set correct timezone
  require 'time'
  timezone = TIME_ZONE
  config.vm.provision :shell, :inline => "if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo \"#{timezone}\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi"
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provision "shell", path: "scripts/provision.sh"
  # config.vm.network "forwarded_port", guest: 8080, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 9090

end
