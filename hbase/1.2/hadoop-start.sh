#!/bin/bash

$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver

echo "########### test"
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /test/f1
$HADOOP_HOME/bin/hdfs dfs -ls /
