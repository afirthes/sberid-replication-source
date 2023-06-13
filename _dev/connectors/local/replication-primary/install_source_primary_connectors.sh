#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "deploy connectors"

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@idpdb-source-primary-connector.json" \
  http://localhost:28083/connectors/idpdb-source-primary-connector/config

printf "\nconnector has been deployed"
