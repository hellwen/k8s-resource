#!/bin/bash

source /etc/profile

echo "========================================================================"
echo "init os base in centos:7-onbuild"
echo "========================================================================"
/init.sh

echo "========================================================================"
echo "init & start zookeeper"
echo "========================================================================"
mkdir -p /data/zk/data
mkdir -p /data/zk/log

#/peer-finder -on-change=/usr/local/on-change.sh -on-start=/usr/local/on-start.sh -service=zookeeper -ns=development
/peer-finder -on-change=/usr/local/on-change.sh -on-start=/usr/local/on-change.sh -service=zookeeper -ns=development

echo "---------------------------"
echo "running..."
echo "---------------------------"
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
