#!/bin/bash

cat << EOF > $DRILL_HOME/conf/drill-override.conf
drill.exec: {
  cluster-id: "drillbits1"
  rpc: {
    user: {
      server: {
        port: 31010
        threads: 1
      }
      client: {
        threads: 1
      }
    },
    bit: {
      server: {
        port : 31011,
        retry:{
          count: 7200,
          delay: 500
        },
        threads: 1
      }
    },
  	use.ip : false
  },
  zk.connect: "<zkhostname1>:<port>,<zkhostname2>:<port>,<zkhostname3>:<port>"
  memory: {
    top.max: 1000000000000,
    operator: {
      max: 20000000000,
      initial: 10000000
    },
    fragment: {
      max: 20000000000,
      initial: 20000000
    }
  },
}
EOF
