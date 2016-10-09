FROM 10.0.12.203:32000/centos:7-onbuild.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# java
ADD tarballs/jre-8u101-linux-x64.tar.gz /usr/local
RUN cd /usr/local && \
    ln -s jre1.8.0_101 jre && \
    echo "export JAVA_HOME=/usr/local/jre" >> /etc/profile && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile

# zookeeper
ADD tarballs/zookeeper-3.4.9.tar.gz /usr/local

ENV ZK_HOME /usr/local/zk
RUN cd /usr/local && \
    ln -s zookeeper-3.4.9 zk && \
    echo "export ZK_HOME=$ZK_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ZK_HOME/bin" >> /etc/profile

ADD zk_init.sh   /usr/local/zk_init.sh
ADD zk_start.sh  /usr/local/zk_start.sh
ADD zk_stop.sh   /usr/local/zk_stop.sh
RUN chmod +x /usr/local/*.sh

# os script
ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]

# zk
EXPOSE 2181
# peer
EXPOSE 2191
# leader-election
EXPOSE 2192
