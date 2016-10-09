#!/bin/bash

source /etc/profile

echo "========================================================================"
echo "init os base in centos:7-onbuild"
echo "========================================================================"
/init.sh

echo "========================================================================"
echo "init & start zookeeper"
echo "========================================================================"
/usr/local/zk_init.sh
/usr/local/zk_start.sh

echo "---------------------------"
echo "running..."
echo "---------------------------"
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
