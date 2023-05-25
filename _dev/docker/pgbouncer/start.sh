#!/bin/bash
sh -c 'echo $$; /usr/local/bin/reload.sh &'
exec /usr/local/bin/pgbouncer /etc/pgbouncer/pgbouncer.ini
