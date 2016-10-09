#!/bin/bash

mkdir -p /data/zk/data
mkdir -p /data/zk/log

cat << EOF > $ZK_HOME/conf/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/zk/data/
dataLogDir=/data/zk/log/
clientPort=2181

server.1=${ZK_SERVER_NAME}-1:2191:2192
server.2=${ZK_SERVER_NAME}-2:2191:2192
server.3=${ZK_SERVER_NAME}-3:2191:2192
EOF

hostname | awk -F- '{print $2+1}' > /data/zk/data/myid

cat << EOF > /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
fe00::0	ip6-mcastprefix
fe00::1	ip6-allnodes
fe00::2	ip6-allrouters
zookeeper-0.zookeeper.development.svc.zeusis.com        zookeeper-1
zookeeper-1.zookeeper.development.svc.zeusis.com        zookeeper-2
zookeeper-2.zookeeper.development.svc.zeusis.com        zookeeper-3
EOF
