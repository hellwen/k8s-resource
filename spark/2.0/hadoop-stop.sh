#!/bin/bash

# stop hadoop
$HADOOP_PREFIX/sbin/stop-dfs.sh
$HADOOP_PREFIX/sbin/stop-yarn.sh
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh stop historyserver
