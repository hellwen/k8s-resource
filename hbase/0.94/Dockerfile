FROM k8s-registry.zeusis.com:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

# install package
ADD tarballs/hbase-0.94.27.tar.gz           /usr/local

# hbase
ENV HBASE_HOME /usr/local/hbase
RUN cd /usr/local && \
    ln -s hbase-0.94.27 hbase && \
    echo "export HBASE_HOME=$HBASE_HOME" >> /etc/profile && \
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
