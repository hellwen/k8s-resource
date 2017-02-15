FROM k8s-registry.zeusis.com:32000/centos:7.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# java
ENV JAVA_HOME  /usr/local/jre
ADD jre-8u101-linux-x64.tar.gz /usr/local
RUN cd /usr/local && \
    ln -s jre1.8.0_101 jre && \
    echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
