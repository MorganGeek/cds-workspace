set -euox pipefail

if [ ! -x /usr/bin/ansible ]; then
  echo "Installing epel-release..."
  yum -y install epel-release
  echo "Installing Ansible & Python dependencies..."
  yum -y install python-pip openssl-devel python27-devel python-devel libffi-devel
  pip install --upgrade pip && yum upgrade python* -y
  pip install -r /vagrant/bootstrap/requirements.txt
else
  echo "ansible is already installed"
fi
