#! /bin/bash

echo ""
echo "########### on-change"
echo ""

SLAVES=$HADOOP_PREFIX/etc/hadoop/slaves
HDFS_SITE=$HADOOP_PREFIX/etc/hadoop/hdfs-site.xml

echo "########### slaves add"
echo "" > ${SLAVES}
while read -ra LINE; do
    PEERS=("${PEERS[@]}" $LINE)
    echo "${LINE}" >> "${SLAVES}"
done

# replication the replicas
echo "########### replicas modifiy"
REPLICAS=${#PEERS[@]}
sed -i "/<name>dfs.replication/ s:.*:<name>dfs.replication<\/name><value>${REPLICAS}<\/value>:" $HDFS_SITE

MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}
HOSTNAME=$(hostname)

echo "########### host info"
echo "i am is  : ${HOSTNAME}"
echo "master is: ${MASTER}"

if [[ "${MASTER}" == *"${HOSTNAME}"* ]]; then
    echo "########### hadoop stop"
    /usr/local/hadoop-stop.sh
    echo "########### hadoop start"
    /usr/local/hadoop-start.sh
    echo "########### finished"
fi
