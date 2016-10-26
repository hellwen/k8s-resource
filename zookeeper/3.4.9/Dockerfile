FROM 10.0.12.207:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# zookeeper
ADD tarballs/zookeeper-3.4.9.tar.gz /usr/local

ENV ZK_HOME /usr/local/zk
RUN cd /usr/local && \
    ln -s zookeeper-3.4.9 zk && \
    echo "export ZK_HOME=$ZK_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ZK_HOME/bin" >> /etc/profile

ADD on-init.sh /usr/local/on-init.sh
ADD on-change.sh /usr/local/on-change.sh
RUN chmod +x /usr/local/*.sh

# on bootstrap
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]

# ssh ports
EXPOSE 2122
# zk
EXPOSE 2181
# peer
EXPOSE 2191
# leader-election
EXPOSE 2192
