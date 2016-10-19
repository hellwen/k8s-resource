FROM 10.0.12.203:32000/centos:7
MAINTAINER hellwen wu <hellwen.wu@gmail.com>

# 163 yum repos
ADD CentOS-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

# time zone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y which tar sudo openssh-server openssh-clients epel-release; \
    yum install -y pwgen rsync net-tools sysstat bind-utils

# passwordless ssh
RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa && \
    echo "UsePAM no" >> /etc/ssh/sshd_config && \
    echo "Port 2122" >> /etc/ssh/sshd_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "LogLevel quiet" >> /etc/ssh/ssh_config && \
    echo "Port 2122" >> /etc/ssh/ssh_config

# install term
RUN yum install -y xterm && \
    echo "# add by init" >> /etc/profile && \
    echo "set -o vi" >> /etc/profile && \
    echo "export TERM=xterm" >> /etc/profile

# make data dir
RUN mkdir -p /data

# entry point
ADD set_root_pw.sh /set_root_pw.sh
ADD init.sh /init.sh
RUN chmod +x /*.sh
ENTRYPOINT ["/init.sh"]

ENV AUTHORIZED_KEYS **None**

EXPOSE 2122
CMD [""]
