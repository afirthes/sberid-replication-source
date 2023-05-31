# SberID Replication Source

Собрать образ kafka-connect (sberid-replication-source) с source и sink библиотеками из корневой директории
```
docker build --tag sberid-replication-source --file docker/Dockerfile .
```
Запустить ./_dev/connectors/local/docker-compose.yml

```
docker-compose up -d
docker-compose logs -f
```

UI доступен по адресу http://localhost:28080

На source БД изменить уровень wal и перезапустить БД (или контейнер)

```sql
ALTER SYSTEM SET wal_level = logical;
```

Отредактировать конфиги source и sink коннекторов, затем запустить скрипт установки коннекторов из директории ./_dev/connectros/local/
```
./install_connectors.sh
```

### Запросы к БД
```sql
SELECT * FROM pg_publication;
SELECT * FROM pg_replication_slots;
SELECT * FROM pg_stat_replication;

SELECT pg_drop_replication_slot('debezium');
```

# Pgbouncer

Используется в качестве пула соединений и для переключения между репликами БД (leader - запись разрешена, replica - запись запрещена)
Для отслеживания изменения конфигурационного файла используется inotifywait

Собрать образ pgbouncer с inotifywait из директории ./_dev/docker/pgbouncer
```
docker build -t pgbouncer .
```

Запустить указав pgbouncer.ini
```
docker run -d --rm \
    --name pgbouncer \
    -v "$(pwd)"/:/etc/pgbouncer/ \
    -p 35432:35432 \
    pgbouncer
```


# Натсройка kafka-connect
Работа с секретами https://docs.confluent.io/platform/current/connect/security.html#externalizing-secrets

