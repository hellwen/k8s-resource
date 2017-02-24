#!/bin/sh
set -e

# alter influxdb urls
if [ -n $INFLUXDB_URLS ]; then
    echo "InfluxDB urls: ${INFLUXDB_URLS}"
    sed -i "/urls =/ s#.*#  urls = [\"${INFLUXDB_URLS}\"]#" $KAPACITOR_CONF
fi

if [ -n $KAPACITOR_HOSTNAME ]; then
    echo "kapacitor hostname: ${KAPACITOR_HOSTNAME}"
    sed -i "/kapacitor-hostname =/ s#.*#  kapacitor-hostname = \"${KAPACITOR_HOSTNAME}\"#" $KAPACITOR_CONF
fi

if [ "${1:0:1}" = '-' ]; then
    set -- kapacitord "$@"
fi

KAPACITOR_HOSTNAME=${KAPACITOR_HOSTNAME:-$HOSTNAME}
export KAPACITOR_HOSTNAME

exec "$@"
