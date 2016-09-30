#!/bin/bash

echo "---------------------------"
echo "config hadoop"
echo "---------------------------"
cat << EOF > $HBASE_HOME/conf/hbase-site.xml
<configuration>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://$HOSTNAME:8020/hbase</value>
    </property>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
</configuration>
EOF

cat << EOF > $HBASE_HOME/conf/regionservers
$HOSTNAME
EOF

sed -i '/^# export JAVA_HOME=/ s:.*:export JAVA_HOME=/usr/local/jre:' $HBASE_HOME/conf/hbase-env.sh

cp $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml $HBASE_HOME/conf/
