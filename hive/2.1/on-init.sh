#! /bin/bash

HOSTS=/etc/hosts

ZK_CFG_BAK=$ZK_HOME/conf/zoo.cfg.bak

cat << EOF > "${ZK_CFG_BAK}"
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/zk/data
dataLogDir=/data/zk/log/
clientPort=2181
EOF

cat << EOF > "${HOSTS}"
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
fe00::0	ip6-mcastprefix
fe00::1	ip6-allnodes
fe00::2	ip6-allrouters
EOF
