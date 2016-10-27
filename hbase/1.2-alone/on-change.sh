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

MY_HOSTNAME=$(hostname)

echo "########### on init"
/usr/local/on-init.sh

echo "########### /etc/hosts"
while read -ra LINE; do
    IP=${LINE#*,}
    DNS=${LINE%%,*}
    HOST=${LINE%%.*}

    echo "${IP} ${DNS} ${HOST}" >> "${HOSTS}"

    PEERS=("${PEERS[@]}" ${DNS})
    #PEERS=("${PEERS[@]}" ${HOST})
done

echo "########### hadoop slaves"
> ${HADOOP_SLAVES}
for peer in ${PEERS[@]}; do
    echo ${peer} >> ${HADOOP_SLAVES}
done
cat ${HADOOP_SLAVES}

echo "########### hbase region servers"
> ${HBASE_REGION}
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

echo "########### host info"
#MASTER=${PEERS[0]}
MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}

echo "i  am  is: ${MY_HOSTNAME}"
echo "master is: ${MASTER}"

if [[ "${MASTER}" == *"${MY_HOSTNAME}"* ]]; then
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
