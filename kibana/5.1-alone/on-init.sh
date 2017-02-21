#! /bin/bash

cat << EOF > $KIBANA_HOME/config/kibana.yml
server.port: 5601
server.host: 0.0.0.0

elasticsearch.url: "http://localhost:9200"

status.allowAnonymous: true
pid.file: /data/kibana/pid
EOF

chown app:app $KIBANA_HOME/config/kibana.yml
