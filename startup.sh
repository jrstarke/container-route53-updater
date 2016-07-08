#! /bin/bash

set -e

public_ip=$(curl $META_DATA_HOST/latest/meta-data/public-ipv4)
private_ip=$(curl $META_DATA_HOST/latest/meta-data/private-ipv4)

echo "public_ip: $public_ip"
echo "private_ip: $private_ip"
