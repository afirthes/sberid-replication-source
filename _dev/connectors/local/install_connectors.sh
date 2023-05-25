#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

export KAFKA_CONNECT_URL=${KAFKA_CONNECT_URL:-http://localhost:28083}

printf "deploy connectors"
for filename in *.json; do
  [ -e "$filename" ] || continue

  printf "\ndeploy connector from file %s\n" "$filename"
  connector_name="${filename/.json/}"
  curl -X DELETE \
    "$KAFKA_CONNECT_URL"/connectors/"$connector_name"
  curl -X PUT \
    -H 'Content-Type: application/json' \
    --data-binary "@$filename" \
    "$KAFKA_CONNECT_URL"/connectors/"$connector_name"/config
  printf "\nconnector has been deployed"
done
printf "\nconnectors deployment has been done"
