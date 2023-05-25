#!/bin/bash
inotifywait -e moved_to -m /etc/pgbouncer |
while read -r directory events filename; do
  echo "$(date +'%Y-%m-%d %T') $directory $events $filename" >> /var/log/pgbouncer/events.log
  sleep 2
  kill -HUP 1
done
