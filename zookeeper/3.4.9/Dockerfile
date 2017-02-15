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

COPY zkGenConfig.sh zkOk.sh zkMetrics.sh $ZK_HOME/bin/

CMD ["zkGenConfig.sh"]
