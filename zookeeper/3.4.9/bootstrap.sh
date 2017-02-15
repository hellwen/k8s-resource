#!/bin/bash

# write myid
num=`echo $ZK_ENSEMBLE | awk '{print NF}'`
if [ "$num" -gt 1 ]; then
    echo $num
    IFS='-' read -ra ADDR <<< "$(hostname)"
    echo `expr "1" + ${ADDR[1]}` > "${ZK_MYID}"
else
    echo 1
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


DOMAIN=`hostname -d`

for s in $ZK_ENSEMBLE
do
    echo "server.$((++i))=${s}.${DOMAIN}:${ZK_SERVER_PORT}:${ZK_ELECTION_PORT}" >> ${ZK_CFG}
done

# start zk
zkServer.sh start-foreground

# waiting...
while true
do
    sleep 60
done
