FROM 10.0.12.207:32000/jre:1.8.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

VOLUME /data

# install package
ADD tarballs/elasticsearch-5.0.0.tar.gz /data

RUN groupadd -g 6110 es && useradd -u 6110 -g es es

RUN chown -R es:es /data

USER es

# es
ENV ES_HOME /data/es
RUN cd /data && \
    ln -s elasticsearch-5.0.0 es && \
    echo "export ES_HOME=$ES_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$ES_HOME/bin" >> /etc/profile

ADD es-start.sh /data/es-start.sh
ADD es-stop.sh  /data/es-stop.sh

# comm
ADD on-init.sh    /data/on-init.sh
ADD on-change.sh  /data/on-change.sh
RUN chmod +x /data/*.sh

# script
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]

# es
EXPOSE 9200 9300
#EXPOSE 9301 9302 9303 9304 9305
# ssh
EXPOSE 2122
