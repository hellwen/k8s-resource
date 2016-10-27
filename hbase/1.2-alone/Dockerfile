FROM 10.0.12.207:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

# install package
ADD tarballs/hadoop-2.7.3.tar.gz              /usr/local
ADD tarballs/hbase-1.2.3-bin.tar.gz           /usr/local

# hadoop
ENV HADOOP_HOME /usr/local/hadoop
RUN cd /usr/local && \
    ln -s hadoop-2.7.3 hadoop && \
    echo "export HADOOP_HOME=$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_COMMON_HOME=\$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_HDFS_HOME=\$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_MAPRED_HOME=\$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_YARN_HOME=\$HADOOP_HOME" >> /etc/profile && \
    echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> /etc/profile && \
    echo "export YARN_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> /etc/profile

ADD hadoop-init.sh  /usr/local/hadoop-init.sh
ADD hadoop-start.sh /usr/local/hadoop-start.sh
ADD hadoop-stop.sh  /usr/local/hadoop-stop.sh

# hbase
ENV HBASE_HOME /usr/local/hbase
RUN cd /usr/local && \
    ln -s hbase-1.2.3 hbase && \
    echo "export HBASE_HOME=$HBASE_HOME" >> /etc/profile && \
    echo "export HBASE_CLASSPATH=\$HADOOP_CONF_DIR" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HBASE_HOME/bin" >> /etc/profile

ADD hbase-init.sh  /usr/local/hbase-init.sh
ADD hbase-start.sh /usr/local/hbase-start.sh
ADD hbase-stop.sh  /usr/local/hbase-stop.sh

# comm
ADD on-init.sh    /usr/local/on-init.sh
ADD on-change.sh  /usr/local/on-change.sh
RUN chmod +x /usr/local/*.sh

# script
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]

# Hbase ports
EXPOSE 60000 60010 60020 60030 8080 16010 16020 16030 56567
# hbase thrift
EXPOSE 9090
# hbase rest
EXPOSE 8090
# zookeeper
EXPOSE 2191 2192 2181
