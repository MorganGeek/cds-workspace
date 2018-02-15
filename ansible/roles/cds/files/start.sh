#sudo yum upgrade python*
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
