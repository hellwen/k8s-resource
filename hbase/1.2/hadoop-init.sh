#!/bin/bash

#MASTER=${SERVICE}-0
MASTER=${SERVICE}-0.${SERVICE}.${NAMESPACE}.svc.zeusis.com

cat << EOF > $HADOOP_CONF_DIR/core-site.xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://${MASTER}:8020</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_CONF_DIR/hdfs-site.xml
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
        <name>dfs.replication</name><value>1</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_CONF_DIR/mapred-site.xml
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>${MASTER}:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>${MASTER}:19888</value>
    </property>
</configuration>
EOF

cat << EOF > $YARN_CONF_DIR//yarn-site.xml
<configuration>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>${MASTER}:8032</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
EOF

cat << EOF > $HADOOP_CONF_DIR/slaves
${MASTER}
EOF

sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/local/jre\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
