FROM redhat.registry-ci.delta.sbrf.ru/ubi8/openjdk-11@sha256:5d3a4fbc094c2c29bf7ee0b9715e08d156d8c86a9d56f5e974439077756891f5

USER root

COPY docker/rpm /tmp

RUN echo "Europe/Moscow" > /etc/timezone \
    && rpm -ivh /tmp/*.rpm \
    && rm -f /tmp/*.rpm

ADD docker/confluentinc-kafka-connect-jdbc-10.7.0.tar.gz /usr/share/java/kafka/
ADD docker/debezium-connector-postgres-1.8.1.Final-plugin.tar.gz /usr/share/java/kafka/
USER 1001

ENTRYPOINT ["connect-distributed", "/etc/kafka/connect-distributed.properties"]
