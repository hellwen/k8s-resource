#!/bin/bash

# "discovery.zen.ping.unicast.hosts:"
# "    - ${peer}:9300"
# "discovery.zen.minimum_master_nodes: 2"

su - es -c "$ES_HOME/bin/elasticsearch -d"

tail -f /data/es/log/myes.log

while true
do
    sleep 10
done
