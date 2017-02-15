FROM k8s-registry.zeusis.com:32000/java:8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

RUN yum install -y ssh pdsh && \
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys && \
    yum clean all

# hbase
ENV HBASE_VERSION 1.2.4
ENV HBASE_HOME /usr/local/hbase
RUN yum install -y wget && \
    cd /usr/local && \
    wget http://apache.mirrors.tds.net/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \
    tar -zxf hbase-${HBASE_VERSION}-bin.tar.gz && \
    mv hbase-${HBASE_VERSION} hbase && \
    rm -f hbase-${HBASE_VERSION}-bin.tar.gz && \
    { rm -rf hbase/{docs,src}; : ; } && \
    echo "export HBASE_HOME=$HBASE_HOME" >> /etc/profile && \
    echo "export HBASE_CLASSPATH=\$HADOOP_CONF_DIR" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HBASE_HOME/bin" >> /etc/profile && \
    yum clean all && yum remove -y wget

COPY entrypoint.sh /

COPY hbase-site.xml $HBASE_HOME/conf/

RUN mkdir -p /data/hbase && \
    mkdir -p /data/zookeeper

# Stargate  8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 2181 8080 8085 9090 9095 16000 16010 16201 16301

CMD ["/entrypoint.sh"]
