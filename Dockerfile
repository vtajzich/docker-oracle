FROM store/oracle/database-enterprise:12.2.0.1-slim

USER root

RUN yum -y install nc

USER oracle

ADD image_content/patch_dockerInitScript.sh /tmp/
ADD image_content/start.sh /tmp/

COPY image_content/startup-scripts/*.sql /docker-initdb/startup/
COPY image_content/setup-scripts/*.sql /docker-initdb/setup/

RUN /tmp/patch_dockerInitScript.sh

VOLUME /docker-initdb/startup
VOLUME /docker-initdb/setup

CMD /tmp/start.sh
