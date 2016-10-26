#!/bin/bash

$HBASE_HOME/bin/hbase-daemon.sh stop rest
$HBASE_HOME/bin/stop-hbase.sh
rm -rf $HBASE_HOME/logs/*
