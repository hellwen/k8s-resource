FROM k8s-registry.zeusis.com:32000/alpine:3.4

ENV KAPACITOR_VERSION 1.2.0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache --virtual .build-deps wget gnupg tar ca-certificates && \
    update-ca-certificates && \
    gpg --keyserver hkp://ha.pool.sks-keyservers.net \
        --recv-keys 05CE15085FC09D18E99EFB22684A14CF2582E0C5 && \
    cd /tmp && \
    wget -q https://dl.influxdata.com/kapacitor/releases/kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz.asc && \
    wget -q https://dl.influxdata.com/kapacitor/releases/kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz && \
    gpg --batch --verify kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz.asc kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz && \
    tar -xzf kapacitor-${KAPACITOR_VERSION}-static_linux_amd64.tar.gz && \
    rm -f /tmp/kapacitor*/kapacitor.conf && \
    cp -a /tmp/kapacitor*/* /usr/bin/ && \
    rm -rf *.tar.gz* /tmp/kapacitor* /root/.gnupg && \
    apk del .build-deps

ADD kapacitor.conf /etc/kapacitor/kapacitor.conf

EXPOSE 9092

VOLUME /data

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["kapacitord"]
