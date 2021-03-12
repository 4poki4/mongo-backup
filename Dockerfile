FROM tiredofit/mongodb-backup
ENV DB_DUMP_TARGET=/backups/hourly
ENV MD5=FALSE
ENV DB_DUMP_DEBUG=FALSE
ENV DB_CLEANUP_TIME=1440
COPY mounth.sh /etc/periodic/mounthly/mounth.sh
COPY day.sh /etc/periodic/daily/day.sh
RUN chmod +x /etc/periodic/mounthly/* /etc/periodic/daily/*
RUN apk update && apk del zabbix-agent
RUN rm /usr/sbin/zabbix_agentd /usr/sbin/zabbix_sender
RUN rm -rf /etc/fix-attrs.d/02-zabbix /etc/services.available/03-zabbix /etc/cont-init.d/03-zabbix
RUN mkdir -p /backups/mounthly
RUN mkdir -p /backups/daily
ENTRYPOINT /init
