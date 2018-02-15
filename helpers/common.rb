required_plugins = %w( vagrant-vbguest vagrant-cachier)
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

def forward_ports(node, ports)
  ports.each do |port|
    node.vm.network "forwarded_port", guest: port, host: "5#{port}", auto_correct: true
  end
end

def provision_ansible(node, playbook, inventory)
  node.vm.provision :shell, inline: "sudo PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=1 ansible-playbook #{playbook} -i #{inventory} -c local"
end
