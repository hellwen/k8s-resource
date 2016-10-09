#!/bin/bash

cat << EOF >> $KAFKA_HOME/config/server.properties
advertised.host.name=${POD_IP}
EOF
