FROM 10.0.12.203:32000/centos:7-onbuild.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# java
ADD tarballs/jre-8u101-linux-x64.tar.gz /usr/local
RUN cd /usr/local && \
    ln -s jre1.8.0_101 jre && \
    echo "export JAVA_HOME=/usr/local/jre" >> /etc/profile && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile

