FROM 10.0.12.207:32000/alpine

MAINTAINER Dean.wu <hellwen.wu@gmail.com>

ENV FILEBEAT_VERSION 5.0.0

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

ADD filebeat.yaml               /usr/local/bin/
ADD filebeat.template.json      /usr/local/bin/

WORKDIR /usr/local/bin
#CMD ["filebeat", "-e", "-d", "*", "-c", "filebeat.yaml"]
CMD ["filebeat", "-e", "-c", "filebeat.yaml"]
