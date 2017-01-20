#! /bin/sh

THIS_NAME=k8s_master_1
THIS_IP=192.168.72.128

./etcd \
--name ${THIS_NAME} \
--data-dir=data \
--initial-cluster-token etcd-cluster-1 \
--initial-cluster k8s_master_1=http://192.168.72.128:2380,k8s_node_0=http://192.168.72.63:2380,k8s_node_1=http://192.168.72.233:2380 \
--initial-advertise-peer-urls http://${THIS_IP}:2380 \
--listen-peer-urls http://${THIS_IP}:2380 \
--advertise-client-urls http://${THIS_IP}:2379 \
--listen-client-urls http://${THIS_IP}:2379,http://127.0.0.1:2379 > etcd.log 2>&1
