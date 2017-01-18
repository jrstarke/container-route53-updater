#! /bin/bash

set -e

function clean_up {

  # Perform program exit housekeeping
  # Optionally accepts an exit status
  
  echo "Shutting down"
  exit $1
}

trap clean_up SIGTERM

if [[ -n "$PUBLIC_IP_HOSTED_ZONE" ]] && [[ -n "$PUBLIC_IP_DOMAIN" ]]; then
    public_ip=$(curl -f $META_DATA_HOST/latest/meta-data/public-ipv4)

    if [[ -n "$public_ip" ]]; then
        route53 change-resource-record-sets --hosted-zone-id $PUBLIC_IP_HOSTED_ZONE --change-batch "{
            \"Changes\": [
                {
                    \"Action\": \"UPSERT\",
                    \"ResourceRecordSet\": {
                        \"Name\": \"$PUBLIC_IP_DOMAIN\",
                        \"Type\": \"A\",
                        \"TTL\": 60, \"ResourceRecords\": [
                            {
                                \"Value\":\"$public_ip\"
                            }
                        ]
                    }
                }
            ]
        }"
    fi
fi

if [[ -n "$LOCAL_IP_HOSTED_ZONE" ]] && [[ -n "$LOCAL_IP_DOMAIN" ]]; then
    local_ip=$(curl -f $META_DATA_HOST/latest/meta-data/local-ipv4)

    if [[ -n "$local_ip" ]]; then
        route53 change-resource-record-sets --hosted-zone-id $LOCAL_IP_HOSTED_ZONE --change-batch "{
            \"Changes\": [
                {
                    \"Action\": \"UPSERT\",
                    \"ResourceRecordSet\": {
                        \"Name\": \"$LOCAL_IP_DOMAIN\",
                        \"Type\": \"A\",
                        \"TTL\": 60, \"ResourceRecords\": [
                            {
                                \"Value\":\"$local_ip\"
                            }
                        ]
                    }
                }
            ]
        }"
    fi
fi

# Wait for the machine to be terminated
while true; do sleep 86400 & wait; done
