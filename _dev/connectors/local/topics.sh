# connect-configs
docker compose exec kafka \
kafka-topics --create \
--topic source.primary.connect-configs \
--bootstrap-server localhost:9092 \
--replication-factor 1 \
--partitions 1 \
--config cleanup.policy=compact \
--config compression.type=producer

# connect-offsets
docker compose exec kafka \
kafka-topics --create \
--topic source.primary.connect-offsets \
--bootstrap-server localhost:9092 \
--replication-factor 1 \
--partitions 1 \
--config cleanup.policy=compact \
--config compression.type=producer

# connect-status
docker compose exec kafka \
kafka-topics --create \
--topic source.primary.connect-status \
--bootstrap-server localhost:9092 \
--replication-factor 1 \
--partitions 1 \
--config cleanup.policy=compact \
--config compression.type=producer

## __consumer_offsets
#docker compose exec kafka \
#kafka-topics --create \
#--topic __consumer_offsets \
#--bootstrap-server localhost:9092 \
#--replication-factor 1 \
#--partitions 5 \
#--config cleanup.policy=compact \
#--config compression.type=producer

# Табличный топик
# localhost.public.customers
docker compose exec kafka \
kafka-topics --create \
--topic idpdb.primary.customers \
--bootstrap-server localhost:9092 \
--replication-factor 1 \
--partitions 1 \

# Топик по транзакциям
# localhost.transaction
docker compose exec kafka \
kafka-topics --create \
--topic idpdb.primary.transaction \
--bootstrap-server localhost:9092 \
--replication-factor 1 \
--partitions 1 \

