FROM k8s-registry.zeusis.com:32000/alpine:3.4
MAINTAINER Dean.wu <hellwen.wu@gmail.com>

ENV FILEBEAT_VERSION 5.2.1

# Set the timezone
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

# Install NodeJs
RUN apk --no-cache add wget && \
    wget --no-check-certificate https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz && \
    tar xzf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-linux-x86_64/filebeat /usr/local/bin && \
    rm -rf /filebeat* && \
    apk del wget

ENV BEATS_HOME /usr/local/beats/
ENV ELASTICSEARCH_HOSTS "192.168.61.2:32004"
ENV LOG_LEVEL info
ENV ELASTICSEARCH_INDEX kube

RUN mkdir -p ${BEATS_HOME}

COPY filebeat.yaml filebeat.template.json ${BEATS_HOME}

COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
