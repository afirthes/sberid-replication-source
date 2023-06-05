# SberID Replication Source

Для локального запуска нужно собрать два образа:
kafka-connect-sink
kafka-connect-source

Докер образ kafka-connect-source находится в данном проекте и собирается (команда из корневой директории проекта):

```
docker build --tag kafka-connect-source --file docker/Dockerfile .
```

Докер образ для kafka-connect-sink находится в другом проекте - sberid-replication-sink

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

