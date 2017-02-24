FROM k8s-registry.zeusis.com:32000/centos:7
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# 163 yum repos
ADD CentOS-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo

# time zone
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install dev tools
RUN yum clean all && \
    rpm --rebuilddb && \
    yum install -y which tar pwgen net-tools sysstat

# install term
RUN echo "# add by init" >> /etc/profile && \
    echo "set -o vi" >> /etc/profile

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
COPY peer-finder set_root_pw.sh /
