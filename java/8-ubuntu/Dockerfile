FROM k8s-registry.zeusis.com:32000/ubuntu:16.10

MAINTAINER Hellwen.wu

# A few problems with compiling Java from source:
#  1. Oracle.  Licensing prevents us from redistributing the official JDK.
#  2. Compiling OpenJDK also requires the JDK to be installed, and it gets
#       really hairy.

RUN echo 'deb http://mirrors.163.com/ubuntu yakkety main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb http://mirrors.163.com/ubuntu yakkety-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.163.com/ubuntu yakkety-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.163.com/ubuntu yakkety-security main restricted universe multiverse' >> /etc/apt/sources.list

#RUN apt-get update && apt-get install -y --no-install-recommends \
#		bzip2 \
#		unzip \
#		xz-utils \
#	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_VERSION 8u111

RUN set -x \
	&& apt-get update \
	&& apt-get install -y openjdk-8-jdk \
	&& rm -rf /var/lib/apt/lists/* \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]
