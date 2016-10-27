#! /bin/bash

echo ""
echo "########### on-change"
echo ""

# hosts config
HOSTS=/etc/hosts

# zk config
ZK_CFG=$ZK_HOME/conf/zoo.cfg
ZK_CFG_BAK=$ZK_HOME/conf/zoo.cfg.bak
ZK_MY_ID=/data/zk/data/myid

# drill config
DRILL_CONF=$DRILL_HOME/conf/drill-override.conf

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
done

echo "########### zk myid"
IFS='-' read -ra ADDR <<< "${MY_HOSTNAME}"
echo $(expr "1" + "${ADDR[1]}") > "${ZK_MY_ID}"

echo "########### zk servers"
i=0
for peer in ${PEERS[@]}; do
    let i=i+1
    echo "server.${i}=${peer}:2191:2192" >> "${ZK_CFG_BAK}"
done
cp ${ZK_CFG_BAK} ${ZK_CFG}

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

echo "i  am  is: ${MY_HOSTNAME}"
echo "master is: ${MASTER}"

echo "########### zk restart"
$ZK_HOME/bin/zkServer.sh restart

echo "########### drill restart"
$DRILL_HOME/bin/drillbit.sh restart

echo "########### finished"
