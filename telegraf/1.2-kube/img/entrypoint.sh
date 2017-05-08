#!/bin/sh
set -e

echo "Host Name set (${HOSTNAME})"
echo "Name Space set (${POD_NAMESPACE})"
echo "Node Name set (${NODE_NAME})"

API_URL=${API_URL:-"https://kubernetes.default"}

export BEARER_TOKEN_PATH TOKEN NODE_NAME NODE_IP AGENT_HOSTNAME
BEARER_TOKEN_PATH=/var/run/secrets/kubernetes.io/serviceaccount/token
TOKEN="$(cat $BEARER_TOKEN_PATH)"
NODE_IP="$(curl -s "$API_URL/api/v1/namespaces/$POD_NAMESPACE/pods/$HOSTNAME" --header "Authorization: Bearer $TOKEN" --insecure | jq -r '.status.hostIP')"
echo "Node IP set (${NODE_IP})"
AGENT_HOSTNAME=$NODE_NAME

if [ -n "$ENABLE_KUBERNETES_API" ]; then
  export KUBERNETES_API_BEARER_TOKEN_PATH=${BEARER_TOKEN_PATH}
  export KUBERNETES_API_URLS="\"$API_URL/metrics\""
  echo "Setting KUBERNETES_API_URLS: $KUBERNETES_API_URLS"
fi

if [ -n "$ENABLE_KUBERNETES" ]; then
  export KUBERNETES_BEARER_TOKEN_PATH=${BEARER_TOKEN_PATH}
  export KUBERNETES_URL="http://${NODE_IP}:10255"
  echo "Setting KUBERNETES_URLS: $KUBERNETES_URLS"
fi

if [ -n "$ENABLE_KUBE_STATE_METRICS" ]; then
  export KUBE_STATE_METRICS_BEARER_TOKEN_PATH=${BEARER_TOKEN_PATH}
  export KUBE_STATE_METRICS_URLS="\"http://kube-state-metrics:8080/metrics\""
  echo "Setting KUBE_STATE_METRICS_URLS: $KUBE_STATE_METRICS_URLS"
fi

if [ -n "$ENABLE_PROMETHEUS" ]; then
  export PROMETHEUS_BEARER_TOKEN_PATH=${BEARER_TOKEN_PATH}
  # export PROMETHEUS_URLS="\"$API_URL/api/v1/proxy/nodes/$NODE_NAME/metrics\", \"$API_URL/metrics\""
  # export PROMETHEUS_URLS="\"http://${NODE_IP}:10255/metrics\""
  export PROMETHEUS_URLS="\"$API_URL/api/v1/proxy/nodes/$NODE_NAME/metrics\""
  echo "Setting PROMETHEUS_URLS: $PROMETHEUS_URLS"
fi

# if the influxdb url does not start with a quote, assume it's singular and quote it
if [ "${INFLUXDB_URLS:0:1}" != "\"" ]; then
  export INFLUXDB_URLS="\"$INFLUXDB_URLS\""
fi

echo "Building telegraf.conf!"
envtpl -in telegraf.conf.tmpl | sed  '/^$/d' > telegraf.conf

echo "Finished building toml..."
echo "###########################################"
echo "###########################################"
echo
cat telegraf.conf
# while true do sleep 60; done
echo
echo "###########################################"
echo "  running..."
echo "###########################################"
#telegraf -config telegraf.conf -quiet
telegraf -config telegraf.conf
