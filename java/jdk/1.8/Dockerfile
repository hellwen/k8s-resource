FROM 10.0.12.207:32000/centos:7.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# java
ENV JAVA_HOME /usr/local/jdk
ADD tarballs/jdk1.8.0_101.tar.gz /usr/local
RUN cd /usr/local && \
    ln -s jdk1.8.0_101 jdk && \
    echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
