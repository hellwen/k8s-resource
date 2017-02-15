#!/bin/bash

echo "########### hdfs format"
$HADOOP_HOME/bin/hdfs namenode -format

echo "########### start"
$HADOOP_HOME/sbin/start-dfs.sh
