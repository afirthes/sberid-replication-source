# Debezium Proof Of Concept

Собрать образ kafka-connect с source и sink библиотеками из директории ./docker/kafka-connect
```
docker build -t kafka-connect .
```
Запустить ./connectors/local/docker-compose.yml

```
docker-compose up -d
docker-compose logs -f
```

UI доступен по адресу http://localhost:28080

На source БД изменить уровень wal и перезапустить БД (или контейнер)

```sql
ALTER SYSTEM SET wal_level = logical;
```

Отредактировать конфиги source и sink коннекторов, затем запустить скрипт установки коннекторов из директории ./connectros/local/
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

Собрать образ pgbouncer с inotifywait из директории ./docker/pgbouncer
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