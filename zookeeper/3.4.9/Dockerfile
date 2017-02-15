FROM k8s-registry.zeusis.com:32000/java:8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

RUN yum install -y wget && yum clean all

# zookeeper
ENV ZK_VERSION=3.4.9
ENV ZK_HOME=/usr/local/zk
RUN cd /usr/local && \
    wget "http://apache.mirrors.hoobly.com/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz" && \
    tar -zxf zookeeper-$ZK_VERSION.tar.gz && \
    mv zookeeper-$ZK_VERSION zk && \
    rm -rf zookeeper-$ZK_VERSION.tar.gz \
    $ZK_HOME/CHANGES.txt \
    $ZK_HOME/README.txt \
    $ZK_HOME/NOTICE.txt \
    $ZK_HOME/CHANGES.txt \
    $ZK_HOME/README_packaging.txt \
    $ZK_HOME/build.xml \
    $ZK_HOME/config \
    $ZK_HOME/contrib \
    $ZK_HOME/dist-maven \
    $ZK_HOME/docs \
    $ZK_HOME/ivy.xml \
    $ZK_HOME/ivysettings.xml \
    $ZK_HOME/recipes \
    $ZK_HOME/src \
    $ZK_HOME/zookeeper-$ZK_VERSION.jar.asc \
    $ZK_HOME/zookeeper-$ZK_VERSION.jar.md5 \
    $ZK_HOME/zookeeper-$ZK_VERSION.jar.sha1 && \
    echo "export ZK_HOME=$ZK_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ZK_HOME/bin" >> /etc/profile

ENV PATH $PATH:$ZK_HOME/bin

ENV ZK_CFG=$ZK_HOME/conf/zoo.cfg

ENV ZK_USER=zookeeper

ENV ZK_DATA_DIR=/data/zk/data
ENV ZK_LOG_DIR=/data/zk/log
ENV ZK_MYID=$ZK_DATA_DIR/myid

RUN mkdir -p $ZK_DATA_DIR && \
    mkdir -p $ZK_LOG_DIR && \
    touch $ZK_CFG && \
    touch $ZK_MYID && \
    useradd $ZK_USER && \
    chown -R $ZK_USER:$ZK_USER $ZK_HOME $ZK_DATA_DIR $ZK_LOG_DIR $ZK_MYID

COPY bootstrap.sh zkOk.sh zkMetrics.sh $ZK_HOME/bin/

CMD ["bootstrap.sh"]
