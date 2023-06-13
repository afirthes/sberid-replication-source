#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "deploy connectors"

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@idpdb-customers-sink-standin-connector.json" \
  http://localhost:28086/connectors/idpdb-customers-sink-standin-connector/config

printf "\nconnector has been deployed"

##sleep 20

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@idpdb-table-a-sink-standin-connector.json" \
  http://localhost:28086/connectors/idpdb-table-a-sink-standin-connector/config

printf "\nconnector table-a has been deployed"

#sleep 20

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@idpdb-table-b-sink-standin-connector.json" \
  http://localhost:28086/connectors/idpdb-table-b-sink-standin-connector/config

printf "\nconnector table-b has been deployed"

#sleep 20

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@idpdb-table-c-sink-standin-connector.json" \
  http://localhost:28086/connectors/idpdb-table-c-sink-standin-connector/config

printf "\nconnector table-c has been deployed"