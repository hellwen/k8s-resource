#!/bin/bash

 . /etc/default/scylla-server

CPUSET=""
if [ x"$SCYLLA_CPU_SET" != "x" ]; then
	CPUSET="--cpuset $SCYLLA_CPU_SET"
fi

if [ "$SCYLLA_PRODUCTION" == "true" ]; then
	DEV_MODE=""
	if [ ! -f /var/lib/scylla/.io_setup_done ]; then
		DATA_DIR=`/usr/lib/scylla/scylla_config_get.py --config $SCYLLA_CONF/scylla.yaml --get data_file_directories | head -n1`
		iotune --evaluation-directory $DATA_DIR \
               --format envfile \
               --options-file /var/lib/scylla/io.conf \
               $CPUSET \
               --timeout 600

		if [ $? -ne 0 ]; then
			echo "/var/lib/scylla did not pass validation tests, it may not be on XFS and/or has limited disk space."
			echo "This is a non-supported setup, please bind mount an XFS volume."
			exit 1
		fi
		touch /var/lib/scylla/.io_setup_done
	fi
	source /var/lib/scylla/io.conf
else
	DEV_MODE="--developer-mode true"
fi

if [ x"$LISTEN_ADDRESS" == "x" ];then
	LISTEN_ADDRESS=$(hostname -i)
fi

if [ x"$SCYLLA_SEEDS" != "x" ];then
	SEEDS=$(echo $SCYLLA_SEEDS | tr "," "\n" | xargs getent hosts | awk '{ print $1 }' | tr "\n" "," | head -c -1)
else
	SEEDS="$LISTEN_ADDRESS"
fi

sed -i "s/seeds: \"127.0.0.1\"/seeds: \"$SEEDS\"/g" /etc/scylla/scylla.yaml
sed -i "s/listen_address: localhost/listen_address: $LISTEN_ADDRESS/g" /etc/scylla/scylla.yaml

if [ x"$SCYLLA_BROADCAST_ADDRESS" != "x" ];then
	sed -i "s/.*broadcast_address:.*/broadcast_address: $SCYLLA_BROADCAST_ADDRESS/g" /etc/scylla/scylla.yaml
fi

if [ x"$SCYLLA_SMP" == "x" ];then
	SCYLLA_SMP=1
fi

if [ x"$SCYLLA_MEMORY" == "x" ];then
	SCYLLA_MEMORY="1G"
fi

/usr/bin/scylla --smp $SCYLLA_SMP \
                --memory $SCYLLA_MEMORY \
                --log-to-syslog 0 \
                --log-to-stdout 1 \
                --default-log-level info \
                --options-file /etc/scylla/scylla.yaml \
                --listen-address $LISTEN_ADDRESS \
                --rpc-address $LISTEN_ADDRESS \
                --network-stack posix \
                $DEV_MODE \
                $SEASTAR_IO \
                $CPU_SET \
                &

source /etc/default/scylla-jmx
export SCYLLA_HOME SCYLLA_CONF
exec /usr/lib/scylla/jmx/scylla-jmx -l /usr/lib/scylla/jmx &

# not perfect, also waits for scylla-jmx only, with scylla not running
wait
