#! /bin/bash

echo ""
echo "########### on-change"
echo ""

MY_HOSTNAME=$(hostname)

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

echo "########### host info"
#MASTER=${PEERS[0]}
MASTER_DNS=${PEERS[0]}
MASTER=${MASTER_DNS%%.*}

echo "i  am  is: ${MY_HOSTNAME}"
echo "master is: ${MASTER}"

echo "########### es stop"
/usr/local/kibana-stop.sh

echo "########### es start"
/usr/local/kibana-start.sh

echo "########### finished"
