#!/bin/bash

#MASTER=${SERVICE}-0
MASTER=${SERVICE}-0.${SERVICE}.${NAMESPACE}.svc.zeusis.com

cat << EOF > $HBASE_HOME/conf/hbase-site.xml
<configuration>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://${MASTER}:8020/hbase</value>
    </property>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
</configuration>
EOF

cat << EOF > $HBASE_HOME/conf/regionservers
${MASTER}
EOF

sed -i '/^# export JAVA_HOME=/ s:.*:export JAVA_HOME=/usr/local/jre:' $HBASE_HOME/conf/hbase-env.sh
