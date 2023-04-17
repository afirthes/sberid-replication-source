#https://catalog.redhat.com/software/containers/ubi8/openjdk-11-runtime/606dcb7d0f75e8ece4deec1f
#https://registry-ci.delta.sbrf.ru/#browse/browse:redhat:v2%2Fubi8%2Fopenjdk-11-runtime%2Ftags%2F1.14
FROM redhat.registry-ci.delta.sbrf.ru/ubi8/openjdk-11-runtime:1.14

ENV  JAVA_OPTS "-Dfile.encoding=UTF-8"

USER root

RUN  mkdir -p /opt/app \
      && echo "Europe/Moscow" > /etc/timezone

COPY  ./entry-point.sh /opt/app/
COPY  ./sberid-debezium/target/*.jar /opt/app/

RUN  useradd --create-home --shell /bin/bash owner \
     && chown --recursive owner /opt/app \
     && chmod +x /opt/app/entry-point.sh \
     && chmod --recursive "g+rwX" /opt/app

USER owner

WORKDIR /opt/app
ENTRYPOINT  ["sh","./entry-point.sh"]