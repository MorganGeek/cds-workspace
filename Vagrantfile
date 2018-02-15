# -*- mode: ruby -*-
# vi: set ft=ruby :

def is_plugin(name)
  if Vagrant.has_plugin?(name)
    puts "using #{name}"
  else
    puts "please run vagrant plugin install #{name}"
    exit(1)
  end
end

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  is_plugin("vagrant-vbguest")
  is_plugin("vagrant-cachier")

  config.cache.auto_detect = true
  config.vbguest.auto_update = true

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  def forward_port(d)
    d.vm.network "forwarded_port", guest: 2015, host: 52015, auto_correct: true
    d.vm.network "forwarded_port", guest: 8081, host: 58081, auto_correct: true
    d.vm.network "forwarded_port", guest: 8082, host: 58082, auto_correct: true
  end

  DEFAULT_MEMORY = 4096

  # setup cds
  config.vm.define :cds do |node|
    node.vm.box = "puppetlabs/centos-7.2-64-nocm"
    node.vm.hostname = "cds.local"
    # configure network
    node.vm.network "private_network", ip: "192.168.11.11"
    forward_port node

    node.vm.provision :shell, path: "bootstrap/run_cds.sh"
    node.vm.provision :shell, inline: "sudo PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=1 ansible-playbook /vagrant/ansible/centos-setup-cds.yml -i /vagrant/ansible/hosts/cds -c local"

    config.ssh.private_key_path= "~/.vagrant.d/insecure_private_key"

    config.vm.provider "virtualbox" do |vbox|
      vbox.memory = DEFAULT_MEMORY
      vbox.name = node.vm.hostname
      vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vbox.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end
  end
end
