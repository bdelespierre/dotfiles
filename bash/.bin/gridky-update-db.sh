#!/bin/bash

DB_HOST="staging-encrypted.cyqtvisijp9d.eu-west-3.rds.amazonaws.com"
STAGING_USER="admin"
STAGING_HOST="web.staging.hosts.gridky.fr"

# start a tunnel
ssh -N -L 3307:${DB_HOST}:3306 ${STAGING_USER}@${STAGING_HOST} &

# grab the tunnel PID
TUNNEL=$!
echo "Tunnel PID: ${TUNNEL}"

function finish {
    # close tunnel
    echo "Closing tunnel ${TUNNEL}"
    kill $TUNNEL
}

# on exit, run finish (works with CTRL+C)
trap finish EXIT

# wait for SSH to connect and open 3307
echo "Connecting..."
sleep 3

# import
for DB in {specific,common}; do
    echo "Importing ${DB}..."
    mysqldump --defaults-file=~/.gridky.cnf  "staging_${DB}" | pv -W | mysql "gridky_${DB}"
    echo "Done importing ${DB}."
done
