#! /bin/bash

cat << EOF > $ES_HOME/config/elasticsearch.yml
cluster.name: myes
network.host: 0.0.0.0
path.data: /data/es/data
path.logs: /data/es/logs
http.port: 9200
transport.tcp.port: 9300
EOF

chown app:app $ES_HOME/config/elasticsearch.yml

cat << EOF > $KIBANA_HOME/config/kibana.yml
server.port: 5601
server.host: 0.0.0.0

elasticsearch.url: "http://localhost:9200"

status.allowAnonymous: true
pid.file: /data/kibana/pid
EOF

chown app:app $KIBANA_HOME/config/kibana.yml
