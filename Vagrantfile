# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  def forward_port(d)
#    d.vm.network "forwarded_port", guest: 3000, host: 53000, auto_correct: true
#   d.vm.network "forwarded_port", guest: 8080, host: 58080, auto_correct: true
#    d.vm.network "forwarded_port", guest: 8083, host: 58083, auto_correct: true
#    d.vm.network "forwarded_port", guest: 8086, host: 58086, auto_correct: true
#    d.vm.network "forwarded_port", guest: 9080, host: 59080, auto_correct: true
#    d.vm.network "forwarded_port", guest: 9082, host: 59082, auto_correct: true
  end

  # setup docker host
  config.vm.define :cds do |d|
    # configure network
    d.vm.box = "puppetlabs/centos-7.2-64-nocm"
    d.vm.hostname = "cds.local"
    d.vm.network "private_network", ip: "192.168.11.11"
    #forward_port d

    d.vm.provision :shell, path: "bootstrap/run_cds.sh"

    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
  end
end
