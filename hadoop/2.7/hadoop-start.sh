#!/bin/bash

sh $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

echo "########### test"
#$HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
$HADOOP_PREFIX/bin/hdfs dfs -ls /

#$HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input
#$HADOOP_PREFIX/bin/hadoop jar $HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep input output 'dfs[a-z.]+'
