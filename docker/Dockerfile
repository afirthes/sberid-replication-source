#FROM registry.sigma.sbrf.ru/dev/ci03254663/ci03254663_saas-sbercrm-plus_dev/cp-kafka-connect:6.2.1
#FROM registry-ci.sigma.sbrf.ru/base/docker.io/confluentinc/cp-kafka-connect:6.2.1
#FROM confluentinc/cp-kafka-connect
FROM redhat.registry-ci.delta.sbrf.ru/ubi8/s2i-core@sha256:1cc2b814e82c3fb345774774da3480adede53b1d12a25275e0416ad816b8e28d

ADD debezium-connector-postgres-1.8.1.Final-plugin.tar.gz /data/connect-jars
ADD confluentinc-kafka-connect-jdbc-10.7.0.tar.gz /data/connect-jars