FROM k8s-registry.zeusis.com:32000/zs/centos:7
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# java
ENV JAVA_HOME /usr

ARG JAVA_VERSION=8
ARG JAVA_RELEASE=JDK

RUN \
    pkg="java-1.$JAVA_VERSION.0-openjdk"; \
    if [ "$JAVA_RELEASE" = "JDK" ]; then \
        pkg="$pkg-devel"; \
    else \
        pkg="$pkg-headless"; \
    fi; \
    yum install -y "$pkg" && \
    yum clean all

RUN echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
