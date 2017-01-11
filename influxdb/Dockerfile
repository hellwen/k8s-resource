FROM k8s-registry.zeusis.com:32000/ubuntu:16.10

MAINTAINER Vishnu kannan "<vishnuk@google.com>"

# Install InfluxDB
ENV INFLUXDB_VERSION 1.1.1

RUN apt-get update && apt-get install -y wget && \
  mkdir /app && cd /app && \
  wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb && \
  dpkg -i /app/influxdb_latest_${INFLUXDB_VERSION}_amd64.deb && \
  rm /app/influxdb_latest_${INFLUXDB_VERSION}_amd64.deb

ENV PATH=/opt/influxdb:$PATH

ADD config.toml /etc/influxdb.toml

# admin, http, udp, cluster, graphite, opentsdb, collectd
EXPOSE 8083 8086 8086/udp 8088 2003 4242 25826

VOLUME ["/data"]

ENTRYPOINT ["influxd", "--config", "/etc/influxdb.toml"]
