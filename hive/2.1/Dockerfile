FROM 10.0.12.207:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

# install package
ADD tarballs/hadoop-2.7.3.tar.gz              /usr/local
ADD tarballs/zookeeper-3.4.9.tar.gz           /usr/local
ADD tarballs/hbase-1.2.3-bin.tar.gz           /usr/local
ADD tarballs/apache-hive-2.1.0-bin.tar.gz     /usr/local
ADD tarballs/apache-drill-1.8.0.tar.gz        /usr/local

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

# zookeeper
ENV ZK_HOME /usr/local/zk
RUN cd /usr/local && \
    ln -s zookeeper-3.4.9 zk && \
    echo "export ZK_HOME=$ZK_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ZK_HOME/bin" >> /etc/profile

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

# hive
ENV HIVE_HOME /usr/local/hive
RUN cd /usr/local && \
    ln -s apache-hive-2.1.0-bin hive && \
    echo "export HIVE_HOME=$HIVE_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HIVE_HOME/bin" >> /etc/profile

ADD tarballs/mysql-connector-java-5.1.40-bin.jar $HIVE_HOME/lib

ADD hive-init.sh  /usr/local/hive-init.sh
ADD hive-start.sh /usr/local/hive-start.sh
ADD hive-stop.sh  /usr/local/hive-stop.sh

# drill
ENV DRILL_HOME /usr/local/drill
RUN cd /usr/local && \
    ln -s apache-drill-1.8.0 drill && \
    echo "export DRILL_HOME=$DRILL_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$DRILL_HOME/bin" >> /etc/profile

ADD drill-init.sh  /usr/local/drill-init.sh
ADD drill-start.sh /usr/local/drill-start.sh
ADD drill-stop.sh  /usr/local/drill-stop.sh

# comm
ADD on-init.sh    /usr/local/on-init.sh
ADD on-change.sh  /usr/local/on-change.sh
RUN chmod +x /usr/local/*.sh

# script
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]

# Hdfs ports
EXPOSE 50010 50020 50070 50470 50075 50475 50090 8020 8019 8485 8480
# Mapred ports
EXPOSE 10020 19888
# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8041 8042 8088 10020 19888
# Hbase ports
EXPOSE 60000 60010 60020 60030 8080 16010 16020 16030 8090
# zookeeper
EXPOSE 2191 2192 2181
# Hive ports
EXPOSE 9083 10000
# drill ports
EXPOSE 31010 31011 31012 8047
