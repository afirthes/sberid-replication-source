FROM registry.sigma.sbrf.ru/base/redhat/rhel7:7.6

COPY libevent-2.0.21-4.el7.x86_64.rpm inotify-tools-3.14-9.el7.x86_64.rpm /tmp/
RUN rpm -i /tmp/libevent-2.0.21-4.el7.x86_64.rpm && rm /tmp/libevent-2.0.21-4.el7.x86_64.rpm
RUN rpm -i /tmp/inotify-tools-3.14-9.el7.x86_64.rpm && rm /tmp/inotify-tools-3.14-9.el7.x86_64.rpm

COPY pgbouncer start.sh reload.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/pgbouncer /usr/local/bin/start.sh /usr/local/bin/reload.sh

USER 1001
CMD ["/usr/local/bin/start.sh"]
