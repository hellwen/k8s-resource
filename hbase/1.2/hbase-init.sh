#!/bin/bash

#MASTER=${HOSTNAME}
MASTER=hbase-0.${SERVICE}.${NAMESPACE}.svc.zeusis.com

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
    <property>
        <name>hbase.master</name>
        <value>${MASTER}:60000</value>
    </property>
    <property>
        <name>hbase.zookeeper.property.dataDir</name>
        <value>/usr/local/zookeeper</value>
    </property>
    <property>
        <name>hbase.zookeeper.property.clientPort</name>
        <value>2181</value>
    </property>
    <property>
        <name>hbase.zookeeper.quorum</name><value>node-a.example.com,node-b.example.com</value>
    </property>
</configuration>
EOF

cat << EOF > $HBASE_HOME/conf/regionservers
${MASTER}
EOF

sed -i '/^# export JAVA_HOME=/ s:.*:export JAVA_HOME=/usr/local/jre:' $HBASE_HOME/conf/hbase-env.sh
sed -i '/^# export HBASE_MANAGES_ZK=/ s:.*:export HBASE_MANAGES_ZK=false:' $HBASE_HOME/conf/hbase-env.sh
