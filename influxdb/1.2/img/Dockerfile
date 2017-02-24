FROM k8s-registry.zeusis.com:32000/zs/centos:7

MAINTAINER Hellwen.wu at zeusis.com

# Install InfluxDB
ENV INFLUXDB_VERSION 1.2.0

RUN yum install -y wget && \
  cd /tmp && \
  wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
  tar -zxf influxdb-${INFLUXDB_VERSION}_linux_amd64.tar.gz && \
  cp influxdb-${INFLUXDB_VERSION}-1/usr/bin/influxd /usr/bin && \
  rm -rf influxdb-${INFLUXDB_VERSION}*

ADD influxdb.conf /etc/influxdb/influxdb.conf

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE 8083 8086 8086/udp 8088

VOLUME ["/data"]

ENTRYPOINT ["influxd", "--config", "/etc/influxdb/influxdb.conf"]
