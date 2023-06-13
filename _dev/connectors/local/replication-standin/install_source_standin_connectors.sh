#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "deploy connectors"

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@idpdb-source-standin-connector.json" \
  http://localhost:28085/connectors/idpdb-source-standin-connector/config

printf "\nconnector has been deployed"
