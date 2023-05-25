#FROM registry.sigma.sbrf.ru/dev/ci03254663/ci03254663_saas-sbercrm-plus_dev/cp-kafka-connect:6.2.1
#FROM registry-ci.sigma.sbrf.ru/base/docker.io/confluentinc/cp-kafka-connect:6.2.1
FROM confluentinc/cp-kafka-connect

ADD debezium-connector-postgres-1.8.1.Final-plugin.tar.gz /data/connect-jars
ADD confluentinc-kafka-connect-jdbc-10.7.0.tar.gz /data/connect-jars