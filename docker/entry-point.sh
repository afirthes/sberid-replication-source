
flush_logs() {
  while true; do
    sleep 1
    sync
  done
}

connect-distributed /etc/kafka/connect-distributed.properties > /dev/stdout 2>&1 &

/connectors/create-connectors.sh > /dev/stdout 2>&1 &

tail -f /dev/null