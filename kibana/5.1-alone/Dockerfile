FROM k8s-registry.zeusis.com:32000/centos:7.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# add user
RUN groupadd -g 6110 app && useradd -u 6110 -g app app

# install package
ADD tarballs/kibana-5.1.1-linux-x86_64.tar.gz /usr/local

# es
ENV KIBANA_HOME /usr/local/kibana
RUN cd /usr/local && \
    ln -s kibana-5.1.1-linux-x86_64 kibana && \
    chown -R app:app kibana-5.1.1-linux-x86_64 && \
    echo "export KIBANA_HOME=$KIBANA_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$KIBANA_HOME/bin" >> /etc/profile

ADD kibana-start.sh   /usr/local/kibana-start.sh
ADD kibana-stop.sh    /usr/local/kibana-stop.sh

# script
ADD on-init.sh    /usr/local/on-init.sh
ADD on-change.sh  /usr/local/on-change.sh
ADD bootstrap.sh  /bootstrap.sh

RUN chown -R app:app /usr/local/es*.sh && \
    chmod +x /usr/local/*.sh && \
    chmod +x /bootstrap.sh

VOLUME /data

ENTRYPOINT ["/bootstrap.sh"]

# kibana
EXPOSE 5601
# ssh
EXPOSE 2122
