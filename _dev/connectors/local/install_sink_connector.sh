#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "deploy connectors"

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@jdbc-sink-connector-customers.json" \
  http://localhost:28084/connectors/sink-connector/config

printf "\nconnector has been deployed"
