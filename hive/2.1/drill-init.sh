#!/bin/bash

cat << EOF > $DRILL_HOME/conf/drill-override.conf
drill.exec:{
  cluster-id: mydrillcluster,
  zk.connect: "<zkhostname1>:<port>,<zkhostname2>:<port>,<zkhostname3>:<port>"
}
EOF
