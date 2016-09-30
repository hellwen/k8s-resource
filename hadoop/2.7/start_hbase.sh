#!/bin/bash

sh $HBASE_HOME/conf/hbase-env.sh

$HBASE_HOME/bin/start-hbase.sh

echo "---------------------------"
echo "test"
echo "---------------------------"

