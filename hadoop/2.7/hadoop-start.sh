#!/bin/bash

$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

echo "########### test"
$HADOOP_PREFIX/bin/hdfs dfs -ls /
