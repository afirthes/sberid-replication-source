#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "deploy connectors"

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@debezium-source-connector.json" \
  http://localhost:28083/connectors/source-connector/config

printf "\nconnector has been deployed"
