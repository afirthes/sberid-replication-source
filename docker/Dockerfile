FROM redhat.registry-ci.delta.sbrf.ru/ubi8/openjdk-11@sha256:5d3a4fbc094c2c29bf7ee0b9715e08d156d8c86a9d56f5e974439077756891f5

#RUN mkdir -p /tmp/confluent-rpm
USER root

COPY /rpm /tmp

RUN echo "Europe/Moscow" > /etc/timezone \
    && rpm -ivh /tmp/*.rpm \
    && rm -f /tmp/*.rpm

USER 1001

#ENTRYPOINT ["tail", "-f", "/dev/null"]
ENTRYPOINT ["connect-distributed", "/etc/kafka/connect-distributed.properties"]