#!/bin/bash

echo "---------------------------"
echo "config hadoop"
echo "---------------------------"
cat << EOF > $HADOOP_PREFIX/etc/hadoop/core-site.xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://$HOSTNAME:8020</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_PREFIX/etc/hadoop/hdfs-site.xml
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/data/dhfs/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/data/dhfs/datanode</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_PREFIX/etc/hadoop/mapred-site.xml
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_PREFIX/etc/hadoop/yarn-site.xml
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <property>
      <name>yarn.application.classpath</name>
      <value>/data/hadoop/etc/hadoop, /data/hadoop/share/hadoop/common/*, /data/hadoop/share/hadoop/common/lib/*, /data/hadoop/share/hadoop/hdfs/*, /data/hadoop/share/hadoop/hdfs/lib/*, /data/hadoop/share/hadoop/mapreduce/*, /data/hadoop/share/hadoop/mapreduce/lib/*, /data/hadoop/share/hadoop/yarn/*, /data/hadoop/share/hadoop/yarn/lib/*</value>
    </property>
    <property>
        <name>yarn.nodemanager.delete.debug-delay-sec</name>
        <value>600</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_PREFIX/etc/hadoop/slaves
$HOSTNAME
EOF

sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/jre\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

echo "---------------------------"
echo "create floder"
echo "---------------------------"
mkdir -p /data/dhfs/namenode
mkdir -p /data/dhfs/datanode

echo "---------------------------"
echo "foramt hdfs"
echo "---------------------------"
$HADOOP_PREFIX/bin/hdfs namenode -format
