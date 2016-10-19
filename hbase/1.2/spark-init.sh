#!/bin/bash

MASTER=hbase-0.${SERVICE}.${NAMESPACE}.svc.zeusis.com

echo "########### spark config"
cat << EOF > $SPARK_HOME/conf/spark-env.sh
export HADOOP_HOME=${HADOOP_HOME}
export HADOOP_CONF_DIR=${HADOOP_CONF_DIR}
export JAVA_HOME=${JAVA_HOME}
export SCALA_HOME=${SCALA_HOME}
export SPARK_MASTER_IP=${MASTER}
export SPARK_MASTER_PORT=7077
export SPARK_WORKER_CORES=1
export SPARK_WORDER_INSTANCES=1
export SPARK_WORKER_MEMORY=1g
EOF

echo << EOF > $SPARK_HOME/conf/slaves
${MASTER}
EOF

cp $SPARK_HOME/conf/log4j.properties.template $SPARK_HOME/conf/log4j.properties
sed -i '/^log4j.rootCategory=/ s:.*:log4j.rootCategory=ERROR, console:' $SPARK_HOME/conf/log4j.properties
