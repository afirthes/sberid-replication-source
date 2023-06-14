FROM redhat.registry-ci.delta.sbrf.ru/ubi8/openjdk-11@sha256:5d3a4fbc094c2c29bf7ee0b9715e08d156d8c86a9d56f5e974439077756891f5

USER root

COPY docker/rpm /tmp

RUN echo "Europe/Moscow" > /etc/timezone \
    && rpm -ivh /tmp/*.rpm \
    && rm -f /tmp/*.rpm

COPY docker/entry-point.sh /connectors/entry-point.sh
RUN chmod +x /connectors/entry-point.sh

COPY docker/create-connectors.sh /connectors/create-connectors.sh
RUN chmod +x /connectors/create-connectors.sh

ADD docker/debezium-connector-postgres-1.8.1.Final-plugin.tar.gz /usr/share/java/kafka/
ADD docker/debezium-scripting-1.5.2.Final.tar.gz /usr/share/java/kafka/

RUN chown 1001 /var/log/kafka/

USER 1001

WORKDIR "/connectors/"
ENTRYPOINT ["sh", "/connectors/entry-point.sh"]
