#!/bin/bash

#sh $HADOOP_CONF_DIR/hadoop-env.sh

$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver

echo "########### test"
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /test/f1
$HADOOP_HOME/bin/hdfs dfs -ls /

#$HADOOP_HOME/bin/hdfs dfs -put $HADOOP_HOME/etc/hadoop/ input
#$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep input output 'dfs[a-z.]+'
