FROM 10.0.12.207:32000/centos:7
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# 163 yum repos
ADD CentOS-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

# time zone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y which tar sudo openssh-server openssh-clients epel-release; \
    yum install -y pwgen rsync net-tools sysstat bind-utils ntp

# install term
RUN yum install -y xterm && \
    echo "# add by init" >> /etc/profile && \
    echo "set -o vi" >> /etc/profile && \
    echo "export TERM=xterm" >> /etc/profile

# start ntp
RUN ntpd -q &

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

# gosu
ENV GOSU_VERSION="1.7"
ENV GOSU_DOWNLOAD_ROOT="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION"
ENV GOSU_DOWNLOAD_KEY="0x036A9C25BF357DD4"

RUN set -x \
    && gpg-agent --daemon \
    && gpg --keyserver pgp.mit.edu --recv-keys $GOSU_DOWNLOAD_KEY \
    && echo "trusted-key $GOSU_DOWNLOAD_KEY" >> /root/.gnupg/gpg.conf \
    && curl -sSL "$GOSU_DOWNLOAD_ROOT/gosu-amd64" > gosu \
    && curl -sSL "$GOSU_DOWNLOAD_ROOT/gosu-amd64.asc" > gosu.asc \
    && gpg --verify gosu.asc \
    && rm -f gosu.asc \
    && mv gosu /usr/bin/gosu \
    && chmod +x /usr/bin/gosu \
    && rm -rf /root/.gnupg

# add files
ADD peer-finder /peer-finder
ADD init.sh /init.sh
ADD set_root_pw.sh /set_root_pw.sh
RUN chmod +x /peer-finder && \
    chmod +x /init.sh && \
    chmod +x /set_root_pw.sh

ENTRYPOINT ["/init.sh"]

EXPOSE 2122
