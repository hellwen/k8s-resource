FROM k8s-registry.zeusis.com:32000/zs/centos:7
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# script
ADD bootstrap.sh /bootstrap.sh
ADD on-change.sh /on-change.sh
RUN chmod +x /bootstrap.sh
RUN chmod +x /on-change.sh

ENTRYPOINT ["/bootstrap.sh"]
