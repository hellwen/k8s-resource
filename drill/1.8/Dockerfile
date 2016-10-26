FROM 10.0.12.207:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# install package
ADD tarballs/zookeeper-3.4.9.tar.gz           /usr/local
ADD tarballs/apache-drill-1.8.0.tar.gz        /usr/local

# zookeeper
ENV ZK_HOME /usr/local/zk
RUN cd /usr/local && \
    ln -s zookeeper-3.4.9 zk && \
    echo "export ZK_HOME=$ZK_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ZK_HOME/bin" >> /etc/profile

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

# zookeeper
EXPOSE 2191 2192 2181
# drill ports
EXPOSE 31010 31011 31012 8047
