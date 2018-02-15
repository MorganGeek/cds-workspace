set -euo pipefail

if [ ! -x /usr/bin/ansible ]; then
  echo "Installing epel..."
  yum -y install epel-release
  echo "Installing Ansible..."
  yum -y install python-pip openssl-devel python27-devel python-devel libffi-devel

  pip install -r /vagrant/scripts/requirements.txt
else
  echo "ansible is already installed"
fi
