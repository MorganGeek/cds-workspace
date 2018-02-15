# -*- mode: ruby -*-
# vi: set ft=ruby :

# def is_plugin(name)
#   if Vagrant.has_plugin?(name)
#     puts "using #{name}"
#   else
#     puts "please run vagrant plugin install #{name}"
#     exit(1)
#   end
# end
require './helpers/common'

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.cache.auto_detect = true
  config.vbguest.auto_update = true

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  DEFAULT_MEMORY = 4096
  DEFAULT_BOX = "puppetlabs/centos-7.2-64-nocm"
  DEFAULT_PRIVATE_KEY_PATH = "~/.vagrant.d/insecure_private_key"

  def configure_vbox(config, node)
    config.vm.provider "virtualbox" do |vbox|
      vbox.memory = DEFAULT_MEMORY
      vbox.name = node.vm.hostname
      vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vbox.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
  end

  SRVNAME = "cds"

  # setup cds
  config.vm.define "#{SRVNAME}" do |node|
    # vm settings (network, hostname ...)
    node.vm.box = "#{DEFAULT_BOX}"
    node.vm.hostname = "#{SRVNAME}.local"
    configure_vbox(config, node)
    node.vm.network "private_network", ip: "192.168.11.11"
    ports = [2015, 8081, 8082]
    forward_ports(node, ports)
    config.ssh.private_key_path= "#{DEFAULT_PRIVATE_KEY_PATH}"

    # provisioning
    node.vm.provision :shell, path: "bootstrap/ansible.sh"
    provision_ansible(node, "/vagrant/ansible/centos-setup-#{SRVNAME}.yml", "/vagrant/ansible/hosts/#{SRVNAME}")
  end
end
