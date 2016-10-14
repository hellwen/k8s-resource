FROM 10.0.12.203:32000/hadoop:2.7.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# hbase
RUN cd /usr/local && \
    ln -s hbase-1.2.3 hbase && \
    echo "export HBASE_HOME=/usr/local/hbase" >> /etc/profile && \
    echo "export PATH=\$PATH:\$HBASE_HOME/bin" >> /etc/profile

ADD init_hbase.sh /usr/local/init_hbase.sh
ADD start_hbase.sh /usr/local/start_hbase.sh
ADD stop_hbase.sh /usr/local/stop_hbase.sh

RUN chmod +x /usr/local/*.sh

# script
ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]

# Hbase ports
EXPOSE 60000 60010 60020 60030 8080 16010 16020 16030
# zookeeper
EXPOSE 2888 3888 2181
# Hive ports
EXPOSE 9083 10000
