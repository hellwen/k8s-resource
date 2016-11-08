#! /bin/bash

echo ""
echo "########### on-change"
echo ""

MY_HOSTNAME=$(hostname)

# hadoop config
ES_CONF=$ES_HOME/config/elasticsearch.yml

echo "########### on init"
/usr/local/on-init.sh

echo "########### /etc/hosts"
while read -ra LINE; do
    IP=${LINE#*,}
    DNS=${LINE%%,*}
    HOST=${LINE%%.*}

    PEERS=("${PEERS[@]}" ${DNS})
    #PEERS=("${PEERS[@]}" ${HOST})

    echo "....................."
    echo ${HOST}
    echo ${MY_HOSTNAME}

    if [[ "${HOST}" == *"${MY_HOSTNAME}"* ]]; then
        echo "+++++++++++++++++++++++++++++"
        MY_IP=$IP
        MY_DNS=$DNS
    fi
done

echo "########### es hosts"
echo "node.name: ${MY_HOSTNAME}" >> "${ES_CONF}"
echo "network.host: ${MY_DNS}" >> "${ES_CONF}"
echo "discovery.zen.minimum_master_nodes: 1" >> "${ES_CONF}"

echo "discovery.zen.ping.unicast.hosts:" >> "${ES_CONF}"
for peer in ${PEERS[@]}; do
    echo "    - ${peer}:9300" >> "${ES_CONF}"
done

echo "########### host info"
#MASTER=${PEERS[0]}
MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}

echo "i  am  is: ${MY_HOSTNAME}"
echo "master is: ${MASTER}"

if [[ "${MASTER}" == *"${MY_HOSTNAME}"* ]]; then
    echo "########### restarting..."

    echo "########### hbase stop"
    #/usr/local/hbase-stop.sh

    echo "########### hadoop start"
    #/usr/local/hadoop-start.sh

    echo "########### finished"
fi
