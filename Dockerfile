FROM store/oracle/database-enterprise:12.2.0.1

USER root

RUN yum -y install nc

RUN mkdir -p /docker-initdb/startup && mkdir -p /docker-initdb/setup

USER oracle

ADD patch_dockerInitScript.sh /tmp/
ADD start.sh /tmp/

RUN /tmp/patch_dockerInitScript.sh

CMD /tmp/start.sh
