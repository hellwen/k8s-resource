#! /bin/bash

cat << EOF > $ES_HOME/config/elasticsearch.yml
cluster.name: myes
path.data: /data/es/data
path.logs: /data/es/log
EOF
