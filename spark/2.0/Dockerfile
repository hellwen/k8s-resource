FROM 10.0.12.203:32000/hadoop:2.7.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# install package
ADD tarballs/hadoop-2.7.3.tar.gz /usr/local

# hadoop
ENV HADOOP_PREFIX /usr/local/hadoop

RUN cd /usr/local && \
    ln -s hadoop-2.7.3 hadoop && \
    echo "export HADOOP_PREFIX=$HADOOP_PREFIX" >> /etc/profile && \
    echo "export HADOOP_COMMON_HOME=$HADOOP_PREFIX" >> /etc/profile && \
    echo "export HADOOP_HDFS_HOME=$HADOOP_PREFIX" >> /etc/profile && \
    echo "export HADOOP_MAPRED_HOME=$HADOOP_PREFIX" >> /etc/profile && \
    echo "export HADOOP_YARN_HOME=$HADOOP_PREFIX" >> /etc/profile && \
    echo "export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop" >> /etc/profile && \
    echo "export YARN_CONF_DIR=$HADOOP_PREFIX/etc/hadoop" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HADOOP_PREFIX/bin" >> /etc/profile


ADD hadoop-init.sh  /usr/local/hadoop-init.sh
ADD hadoop-start.sh /usr/local/hadoop-start.sh
ADD hadoop-stop.sh  /usr/local/hadoop-stop.sh
ADD on-change.sh  /usr/local/on-change.sh
RUN chmod +x /usr/local/*.sh

# script
ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]

# spark ports
EXPOSE 50010 50020 50070 50470 50075 50475 50090 8020 8019 8485 8480
