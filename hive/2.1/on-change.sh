#! /bin/bash

echo ""
echo "########### on-change"
echo ""

# hosts config
HOSTS=/etc/hosts

# hadoop config
HADOOP_SLAVES=$HADOOP_CONF_DIR/slaves
HDFS_SITE=$HADOOP_CONF_DIR/hdfs-site.xml

# hbase config
HBASE_REGION=$HBASE_HOME/conf/regionservers
HBASE_SITE=$HBASE_HOME/conf/hbase-site.xml

# zk config
ZK_CFG=$ZK_HOME/conf/zoo.cfg
ZK_CFG_BAK=$ZK_HOME/conf/zoo.cfg.bak
ZK_MY_ID=/data/zk/data/myid

# drill config
DRILL_CONF=$DRILL_HOME/conf/drill-override.conf

HOSTNAME=$(hostname)

echo "########### on init"
/usr/local/on-init.sh

echo "########### /etc/hosts"
while read -ra LINE; do
    IP=${LINE#*,}
    DNS=${LINE%%,*}
    HOST=${LINE%%.*}

    echo "${IP} ${DNS} ${HOST}" >> "${HOSTS}"

    PEERS=("${PEERS[@]}" ${DNS})
done

echo "########### zk myid"
IFS='-' read -ra ADDR <<< "${HOSTNAME}"
echo $(expr "1" + "${ADDR[1]}") > "${ZK_MY_ID}"

echo "########### zk servers"
i=0
for peer in ${PEERS[@]}; do
    let i=i+1
    echo "server.${i}=${peer}:2191:2192" >> "${ZK_CFG_BAK}"
done
cp ${ZK_CFG_BAK} ${ZK_CFG}

echo "########### hadoop slaves"
echo "" > ${HADOOP_SLAVES}
for peer in ${PEERS[@]}; do
    echo ${peer} >> ${HADOOP_SLAVES}
done
cat ${HADOOP_SLAVES}

echo "########### hbase region servers"
echo "" > ${HBASE_REGION}
ZK_QUORUM="<name>hbase.zookeeper.quorum</name><value>"
for peer in ${PEERS[@]}; do
    echo "${peer}" >> "${HBASE_REGION}"
    ZK_QUORUM="${ZK_QUORUM}${peer},"
done
ZK_QUORUM="${ZK_QUORUM%,*}</value>"
sed -i "/<name>hbase.zookeeper.quorum/ s:.*:${ZK_QUORUM}:" ${HBASE_SITE}
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

echo "########### drill connect"
DRILL_ZKS="zk.connect\:\""
for peer in ${PEERS[@]}; do
    DRILL_ZKS="${DRILL_ZKS}${peer}\:2181,"
done
DRILL_ZKS="${DRILL_ZKS%,*}\""
sed -i "/zk.connect/ s:.*:${DRILL_ZKS}:" ${DRILL_CONF}

echo "########### host info"
MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}

echo "i  am  is: ${HOSTNAME}"
echo "master is: ${MASTER}"

echo "########### zk restart"
$ZK_HOME/bin/zkServer.sh restart

if [[ "${MASTER}" == *"${HOSTNAME}"* ]]; then
    echo "########### restarting..."

    echo "########### hbase stop"
    /usr/local/hbase-stop.sh
    echo "########### hadoop stop"
    /usr/local/hadoop-stop.sh

    echo "########### hadoop start"
    /usr/local/hadoop-start.sh
    echo "########### hbase start"
    /usr/local/hbase-start.sh

    echo "########### finished"
fi

echo "########### drill restart"
$DRILL_HOME/bin/drillbit.sh restart
