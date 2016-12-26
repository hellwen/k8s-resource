#!/bin/bash

source /etc/profile

echo "########### os init"
/init.sh

echo "########### es init"
mkdir -p /data/es/data
mkdir -p /data/es/logs

echo "########### kibana init"
mkdir -p /data/kibana/logs

# change owner
chown -R app:app /data
echo "########### waiting 10 seconds for pods created..."
sleep 10

echo "########### peer-finder running..."
/peer-finder -on-change=/usr/local/on-change.sh -on-start=/usr/local/on-change.sh -service=$SERVICE -ns=$NAMESPACE

echo "########### running..."
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
