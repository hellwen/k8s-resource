# Creates pseudo distributed hadoop 2.7.1
#
# docker build -t sequenceiq/hadoop .

FROM 10.0.12.203:32000/centos:7
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# 163 yum repos
ADD CentOS-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

# time zone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y which tar sudo openssh-server openssh-clients rsync epel-release; \
    yum install -y pwgen

# passwordless ssh
RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    # sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config && \
    echo "Port 2122" >> /etc/ssh/sshd_config

# install term
RUN yum install -y xterm && \
    echo "# add by init" >> /etc/profile && \
    echo "set -o vi" >> /etc/profile && \
    echo "export TERM=xterm" >> /etc/profile

# install package
ADD tarballs/jre-8u101-linux-x64.tar.gz /usr/local
ADD tarballs/kafka_2.11-0.10.0.0.tar.gz /usr/local

# java
RUN cd /usr/local && \
    ln -s jre1.8.0_101 jre && \
    echo "export JAVA_HOME=/usr/local/jre" >> /etc/profile && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile

# kafka
ENV KAFKA_HOME /usr/local/kafka
RUN cd /usr/local && \
    ln -s kafka_2.11-0.10.0.0 kafka && \
    echo "export KAFKA_HOME=$KAFKA_HOME" >> /etc/profile

# script
ADD set_root_pw.sh /set_root_pw.sh
ADD init.sh /init.sh
ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /init.sh && \
    chmod a+x /set_root_pw.sh && \
    chmod a+x /bootstrap.sh

ADD kafka_init.sh /usr/local/kafka_init.sh
ADD kafka_start.sh /usr/local/kafka_start.sh
ADD kafka_stop.sh /usr/local/kafka_stop.sh

RUN chmod +x /usr/local/*.sh

ENTRYPOINT ["/bootstrap.sh"]

EXPOSE 2122
# zk
EXPOSE 2181
# kafka
EXPOSE 9092
