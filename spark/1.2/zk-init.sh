#! /bin/bash

CFG=$ZK_HOME/conf/zoo.cfg
CFG_BAK=$ZK_HOME/conf/zoo.cfg.bak
MY_ID=/data/zk/data/myid

cat << EOF > "${CFG_BAK}"
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/zk/data
dataLogDir=/data/zk/log/
clientPort=2181
EOF
