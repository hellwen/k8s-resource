#! /bin/bash

echo ""
echo "########### on-change"
echo ""

# hadoop config
SLAVES=$HADOOP_CONF_DIR/slaves
HDFS_SITE=$HADOOP_CONF_DIR/hdfs-site.xml

# spark config
SPARK_SLAVES=$SPARK_HOME/conf/slaves

# hbase config
REGION=$HBASE_HOME/conf/regionservers
HBASE_SITE=$HBASE_HOME/conf/hbase-site.xml

# zk config
CFG=$ZK_HOME/conf/zoo.cfg
CFG_BAK=$ZK_HOME/conf/zoo.cfg.bak
MY_ID=/data/zk/data/myid

echo "########### zk myid"
IFS='-' read -ra ADDR <<< "$(hostname)"
echo $(expr "1" + "${ADDR[1]}") > "${MY_ID}"

echo "########### zk init"
/usr/local/zk-init.sh

echo "########### zk servers"
i=0
while read -ra LINE; do
    let i=i+1
    PEERS=("${PEERS[@]}" $LINE)
    echo "server.${i}=${LINE}:2191:2192" >> "${CFG_BAK}"
done
cp ${CFG_BAK} ${CFG}

echo "########### hadoop slaves"
echo "" > ${SLAVES}
for peer in ${PEERS[@]}; do
    echo ${peer} >> ${SLAVES}
done
cat ${SLAVES}

echo "########### spark slaves"
echo "" > ${SPARK_SLAVES}
for peer in ${PEERS[@]}; do
    echo ${peer} >> ${SPARK_SLAVES}
done
cat ${SPARK_SLAVES}

echo "########### hbase region servers"
echo "" > ${REGION}
ZK_QUORUM="<name>hbase.zookeeper.quorum</name><value>"
for peer in ${PEERS[@]}; do
    echo "${peer}" >> "${REGION}"
    ZK_QUORUM="${ZK_QUORUM}${peer},"
done
ZK_QUORUM="${ZK_QUORUM%,*}</value>"
sed -i "/<name>hbase.zookeeper.quorum/ s:.*:${ZK_QUORUM}:" ${HBASE_SITE}

echo "########### hbase region servers"
cat ${REGION}

echo "########### zookeeper quorum"
echo ${ZK_QUORUM}

echo "########### hadoop replicas modifiy"
replicas=${#PEERS[@]}
if [ $replicas -ge 4 ];then
    sed -i "/<name>dfs.replication/ s:.*:<name>dfs.replication<\/name><value>3<\/value>:" $HDFS_SITE
elif [ $replicas -ge 2 ];then
    let rep=$replicas-1
    sed -i "/<name>dfs.replication/ s:.*:<name>dfs.replication<\/name><value>${rep}<\/value>:" $HDFS_SITE
else
    sed -i "/<name>dfs.replication/ s:.*:<name>dfs.replication<\/name><value>1<\/value>:" $HDFS_SITE
fi
cp $HADOOP_CONF_DIR/hdfs-site.xml $HBASE_HOME/conf/

echo "########### host info"
MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}
HOSTNAME=$(hostname)

echo "i am is  : ${HOSTNAME}"
echo "master is: ${MASTER}"

echo "########### zk restart"
$ZK_HOME/bin/zkServer.sh restart

if [[ "${MASTER}" == *"${HOSTNAME}"* ]]; then
    echo "########### restarting..."

    echo "########### spark stop"
    # /usr/local/spark-stop.sh
    echo "########### hbase stop"
    # /usr/local/hbase-stop.sh
    echo "########### hadoop stop"
    /usr/local/hadoop-stop.sh

    echo "########### hadoop start"
    /usr/local/hadoop-start.sh
    echo "########### hbase start"
    # /usr/local/hbase-start.sh
    echo "########### spark start"
    # /usr/local/spark-start.sh

    echo "########### finished"
fi
