#!/bin/bash

source /etc/profile

echo "########### os init"
/init.sh

echo "########### hadoop init"
cd /root/.ssh
cat /.ssh/id_rsa > id_rsa
cat /.ssh/id_rsa.pub > id_rsa.pub

mkdir -p /data/dhfs/namenode
mkdir -p /data/dhfs/datanode

/usr/local/hadoop-init.sh

echo "########### zk init"
mkdir -p /data/zk/data
mkdir -p /data/zk/log

echo "########### drill init"
/usr/local/drill-init.sh

echo "########### peer-finder running..."
/peer-finder -on-change=/usr/local/on-change.sh -on-start=/usr/local/on-change.sh -service=$SERVICE -ns=$NAMESPACE

echo "########### running..."
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
