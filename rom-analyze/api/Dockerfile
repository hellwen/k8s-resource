FROM 10.0.12.207:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# install package
ADD tarballs/zookeeper-3.4.9.tar.gz           /usr/local
ADD tarballs/apache-drill-1.8.0.tar.gz        /usr/local

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
