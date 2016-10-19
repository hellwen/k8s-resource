#!/bin/bash

source /etc/profile

echo "########### init os"
/init.sh

echo "########### init & start hadoop"
cd /root/.ssh
cat /.ssh/id_rsa > id_rsa
cat /.ssh/id_rsa.pub > id_rsa.pub

mkdir -p /data/dhfs/namenode
mkdir -p /data/dhfs/datanode

echo "########### init config"
/usr/local/hadoop-init.sh

echo "########### hdfs format"
$HADOOP_PREFIX/bin/hdfs namenode -format

echo "########### peer-finder running..."
/peer-finder -on-change=/usr/local/on-change.sh -on-start=/usr/local/on-change.sh -service=$SERVICE -ns=$NAMESPACE

echo "########### running..."
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi

