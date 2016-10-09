#!/bin/bash

cat << EOF > $ZK_HOME/conf/zoo.cfg
tickTime=2000
dataDir=/data/zk
clientPort=2181
EOF
