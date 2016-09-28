FROM centos:7
MAINTAINER hellwen wu <hellwen.wu@gmail.com>

# 163 yum repos
ADD CentOS-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum -y install openssh-server openssh-clients epel-release sudo && \
    yum -y install pwgen && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

# time zone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

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

EXPOSE 22
CMD [""]
