#! /bin/bash

set -e

function clean_up {

  # Perform program exit housekeeping
  # Optionally accepts an exit status
  
  echo "Shutting down"
  exit $1
}

trap clean_up SIGTERM

public_ip=$(curl $META_DATA_HOST/latest/meta-data/public-ipv4)
private_ip=$(curl $META_DATA_HOST/latest/meta-data/local-ipv4)

echo "public_ip: $public_ip"
echo "private_ip: $private_ip"

# Wait for the machine to be terminated
while true; do sleep 86400 & wait; done
