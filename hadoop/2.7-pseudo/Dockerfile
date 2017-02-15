FROM k8s-registry.zeusis.com:32000/java:8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

RUN yum install -y ssh pdsh && \
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys && \
    yum clean all

# hadoop
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_HOME   /usr/local/hadoop

RUN yum install -y wget && \
    cd /usr/local && \
    wget http://apache.mirrors.tds.net/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar -zxf hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION hadoop && \
    rm -f hadoop-$HADOOP_VERSION.tar.gz && \
    echo "export HADOOP_PREFIX=$HADOOP_PREFIX" >> /etc/profile && \
    echo "export HADOOP_HOME=$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_YARN_HOME=$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop" >> /etc/profile && \
    echo "export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> /etc/profile && \
    yum clean all && yum remove -y wget

COPY entrypoint.sh /
COPY core-site.xml hdfs-site.xml $HADOOP_HOME/etc/hadoop/

RUN mkdir -p /data/hdfs/namenode && \
    mkdir -p /data/hdfs/datanode

CMD ["/entrypoint.sh"]

# Hdfs ports
EXPOSE 50010 50020 50070 50470 50075 50475 50090 8020 8019 8485 8480
# Mapred ports
EXPOSE 10020 19888
# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8041 8042 8088 10020 19888
