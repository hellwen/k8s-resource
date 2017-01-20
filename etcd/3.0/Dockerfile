FROM k8s-registry.zeusis.com:32000/alpine:3.4

MAINTAINER Dean.wu <hellwen.wu@gmail.com>

ENV ETCD_VERSION v3.0.9

# Set the timezone
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

# RUN cd /tmp && \
    # apk --no-cache add wget && \
    # wget --no-check-certificate https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    # tar xzf etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    # cp etcd-${ETCD_VERSION}-linux-amd64/etcd /usr/local/bin && \
    # rm -rf etcd-${ETCD_VERSION}-linux-amd64 && \
    # apk del wget

ADD etcd /usr/local/bin/etcd

CMD ["etcd", "--version"]
