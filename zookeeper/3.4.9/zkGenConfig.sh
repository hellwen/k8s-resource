#!/bin/bash

ZK_CFG=$ZK_HOME/conf/zoo.cfg
ZK_MYID=/data/zk/myid

ZK_GROUP=zookeeper
ZK_USER=zookeeper

ZK_DATA_DIR=/data/zk/data
ZK_DATA_LOG=/data/zk/log

mkdir -p $ZK_DATA_DIR
mkdir -p $ZK_DATA_LOG

touch $ZK_CFG
touch $ZK_MYID

groupadd $ZK_GROUP && useradd -g $ZK_GROUP $ZK_USER
chown -R $ZK_USER:$ZK_USER $ZK_HOME $ZK_DATA_DIR $ZK_DATA_LOG

# write myid
num=${#ZK_ENSEMBLE[@]}
if [ "$num" -gt 1 ]; then
    IFS='-' read -ra ADDR <<< "$(hostname)"
    echo $(expr "1" + "${ADDR[1]}") > "${ZK_MYID}"
else
    echo "1" > "${ZK_MYID}"
fi

cat << EOF > "${ZK_CFG}"
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/zk/data
dataLogDir=/data/zk/log/
clientPort=2181
EOF

for s in $ZK_ENSEMBLE
do
    echo "server.$((i++))=$s:$ZK_SERVER_PORT:$ZK_ELECTION_PORT" >> ${ZK_CFG}
done
