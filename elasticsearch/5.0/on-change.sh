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

    if [[ "${HOST}" == *"${MY_HOSTNAME}"* ]]; then
        MY_IP=$IP
        MY_DNS=$DNS
    fi
done

echo "########### es hosts"
echo "node.name: ${MY_HOSTNAME}" >> "${ES_CONF}"

echo "discovery.zen.ping.unicast.hosts:" >> "${ES_CONF}"
for peer in ${PEERS[@]}; do
    echo "    - ${peer}:9300" >> "${ES_CONF}"
done

if [ ${#PEERS[@]} -ge 2 ];then
    echo "discovery.zen.minimum_master_nodes: 2" >> "${ES_CONF}"
else
    echo "discovery.zen.minimum_master_nodes: 1" >> "${ES_CONF}"
fi

echo "########### host info"
#MASTER=${PEERS[0]}
MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}

echo "i  am  is: ${MY_HOSTNAME}"
echo "master is: ${MASTER}"

echo "########### es stop"
/usr/local/kibana-stop.sh
/usr/local/es-stop.sh

echo "########### es start"
/usr/local/es-start.sh
/usr/local/kibana-start.sh

echo "########### finished"
