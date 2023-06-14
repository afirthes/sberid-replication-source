
echo "Waiting for Kafka Connect to start listening on kafka-connect  "
while :; do
    # Check if the connector endpoint is ready
    # If not check again
    curl_status=$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)
    echo -e $(date) "Kafka Connect listener HTTP state: " $curl_status " (waiting for 200)"
    if [ $curl_status -eq 200 ]; then
        break
    fi
    sleep 5
done

echo "======> Creating connectors"
printf "deploy connectors"
for filename in *.json; do
  [ -e "$filename" ] || continue

  printf "\ndeploy connector from file %s\n" "$filename"
  connector_name="${filename/.json/}"
  curl -X PUT \
    -H 'Content-Type: application/json' \
    --data-binary "@$filename" \
    http://localhost:8083/connectors/"$connector_name"/config
  printf "\nconnector has been deployed"
done
printf "\nconnectors deployment has been done"
