FROM k8s-registry.zeusis.com:32000/java:8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# add user
RUN groupadd es

# es
ENV ES_VERSION 5.1.1
ENV ES_HOME /usr/local/es

RUN cd /usr/local && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz && \
    mkdir es && \
    tar -zxf elasticsearch-${ES_VERSION}.tar.gz -C es && \
    rm -f elasticsearch-${ES_VERSION}.tar.gz && \
    chown -R es:es es && \
    echo "export ES_HOME=$ES_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ES_HOME/bin" >> /etc/profile && \
    yum clean all && yum remove -y wget

COPY entrypoint.sh /
COPY hbase-site.xml $HBASE_HOME/conf/

RUN mkdir -p /data/hbase && \
    mkdir -p /data/zookeeper

EXPOSE 9200 9300

CMD ["/entrypoint.sh"]

ADD es-start.sh   /usr/local/es-start.sh
ADD es-stop.sh    /usr/local/es-stop.sh

# script
ADD on-init.sh    /usr/local/on-init.sh
ADD on-change.sh  /usr/local/on-change.sh
ADD bootstrap.sh  /bootstrap.sh

RUN chown -R app:app /usr/local/es*.sh && \
    chmod +x /usr/local/*.sh && \
    chmod +x /bootstrap.sh

VOLUME /data

ENTRYPOINT ["/bootstrap.sh"]


