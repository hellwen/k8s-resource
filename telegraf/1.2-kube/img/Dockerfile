FROM k8s-registry.zeusis.com:32000/alpine:3.5

ENV TELEGRAF_VERSION 1.2.1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates

RUN \
  # mirror
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk add --no-cache --virtual .build-deps wget gnupg tar curl && \
  gpg --keyserver hkp://ha.pool.sks-keyservers.net \
      --recv-keys 05CE15085FC09D18E99EFB22684A14CF2582E0C5 && \
  # telegraf
  wget -q https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz.asc && \
  wget -q https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
  gpg --batch --verify telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz.asc telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
  mkdir -p /usr/src /etc/telegraf && \
  tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
  mv /usr/src/telegraf*/telegraf.conf /etc/telegraf/ && \
  chmod +x /usr/src/telegraf*/* && \
  cp -a /usr/src/telegraf*/* /usr/bin/ && \
  rm -rf *.tar.gz* /usr/src /root/.gnupg && \
# envtpl
  wget https://github.com/arschles/envtpl/releases/download/0.2.3/envtpl_linux_amd64 -O /usr/local/bin/envtpl && \
  chmod +x /usr/local/bin/envtpl && \
# jq
  wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O /usr/local/bin/jq && \
  chmod +x /usr/local/bin/jq && \
  apk del .build-deps


RUN \
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk add --no-cache curl

EXPOSE 8125/udp 8092/udp 8094

COPY . /

WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
