#!/bin/bash

$HBASE_HOME/bin/hbase-daemon.sh stop thrift
$HBASE_HOME/bin/stop-hbase.sh
#rm -rf $HBASE_HOME/logs/*
