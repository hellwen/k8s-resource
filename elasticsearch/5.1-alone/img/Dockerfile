FROM k8s-registry.zeusis.com:32000/zs/java:8
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# es
ENV ES_VERSION 5.1.1
ENV ES_HOME /usr/local/es
ENV PATH $PATH:$ES_HOME/bin

RUN \
  yum install -y wget && \
  cd /usr/local && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz && \
  tar -zxf elasticsearch-${ES_VERSION}.tar.gz && \
  mv elasticsearch-${ES_VERSION} es && \
  rm -f elasticsearch-${ES_VERSION}.tar.gz && \
  yum clean all && yum remove -y wget


COPY entrypoint.sh /
COPY elasticsearch.yml $ES_HOME/config/

ENV ES_LOG=/data/es/log/myes.log

RUN \
  mkdir -p /data/es/data && \
  mkdir -p /data/es/log && \
  touch $ES_LOG

RUN \
  useradd es && \
  chown -R es:es /usr/local/es && \
  chown -R es:es /data/es

EXPOSE 9200 9300

CMD ["/entrypoint.sh"]
