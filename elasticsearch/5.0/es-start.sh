#!/bin/bash

$HADOOP_HOME/bin/elasticsearch -Ecluster.name=my_cluster_name -Enode.name=my_node_name -d -p 9200
