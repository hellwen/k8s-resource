#!/bin/sh

cd /go/bin

server_id=`hostname | awk -F- '{print $NF+1}'`

sed -i "/^server.id/ s:.*:server.id ${server_id}:" comet-example.conf

./push-comet -c comet-example.conf
