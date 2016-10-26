#!/bin/bash

$HBASE_HOME/bin/start-hbase.sh
$HBASE_HOME/bin/hbase-daemon.sh start rest

echo "########### hbase test"
echo "list" | $HBASE_HOME/bin/hbase shell -n
