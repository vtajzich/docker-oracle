FROM store/oracle/database-enterprise:12.2.0.1-slim

USER root

RUN yum -y install nc

USER oracle

ADD patch_dockerInitScript.sh /tmp/
ADD start.sh /tmp/

RUN /tmp/patch_dockerInitScript.sh

VOLUME /docker-initdb/startup
VOLUME /docker-initdb/setup

CMD /tmp/start.sh
