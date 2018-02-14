#!/bin/bash
set -euo pipefail

sudo yum update -y
sudo yum install epel-release -y
sudo yum update -y
sudo yum install -y python-pip docker-latest git
sudo service docker-latest start
sudo pip install --upgrade pip
sudo pip install docker-compose
sudo yum upgrade python*

rm -rf cds
git clone https://github.com/ovh/cds.git
cd cds
export HOSTNAME=$(hostname)

# Create PG Database
sudo docker-compose up --no-recreate -d cds-db

# check if db is UP
# check if last log is "LOG:  database system is ready to accept connections"
sudo docker-compose logs

sudo docker-compose up --no-recreate cds-migrate
echo You should have this log: "cds_cds-migrate_1 exited with code 0"

# run API and UI
sudo docker-compose up cds-api cds-ui
