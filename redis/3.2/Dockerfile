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
ADD tarballs/redis-3.2.4.tar.gz /usr/local

# install make tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y make gcc

# redis
ENV REDIS_HOME /usr/local/redis
RUN cd /usr/local && \
    ln -s redis-3.2.4 redis && \
    cd $REDIS_HOME && \
    make && \
    echo "export REDIS_HOME=$REDIS_HOME" >> /etc/profile

# script
ADD set_root_pw.sh /set_root_pw.sh
ADD init.sh /init.sh
ADD bootstrap.sh /bootstrap.sh
RUN chmod a+x /init.sh && \
    chmod a+x /set_root_pw.sh && \
    chmod a+x /bootstrap.sh

ADD redis_init.sh /usr/local/redis_init.sh
ADD redis_start.sh /usr/local/redis_start.sh
ADD redis_stop.sh /usr/local/redis_stop.sh

RUN chmod +x /usr/local/*.sh

ENTRYPOINT ["/bootstrap.sh"]

EXPOSE 2122
EXPOSE 6379
