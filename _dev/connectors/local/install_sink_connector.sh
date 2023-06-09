#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

printf "deploy connectors"

#curl -X PUT \
#  -H 'Content-Type: application/json' \
#  --data-binary "@jdbc-sink-connector-customers.json" \
#  http://localhost:28084/connectors/sink-connector/config
#
#printf "\nconnector has been deployed"

##sleep 20

curl -X PUT \
  -H 'Content-Type: application/json' \
  --data-binary "@jdbc-sink-connector-table-a.json" \
  http://localhost:28084/connectors/sink-connector-a/config

printf "\nconnector table-a has been deployed"
#
##sleep 20
#
#curl -X PUT \
#  -H 'Content-Type: application/json' \
#  --data-binary "@jdbc-sink-connector-table-b.json" \
#  http://localhost:28084/connectors/sink-connector-b/config
#
#printf "\nconnector table-b has been deployed"
#
##sleep 20
#
#curl -X PUT \
#  -H 'Content-Type: application/json' \
#  --data-binary "@jdbc-sink-connector-table-c.json" \
#  http://localhost:28084/connectors/sink-connector-c/config
#
#printf "\nconnector table-c has been deployed"