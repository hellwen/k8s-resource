#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-04-24 21:29:46 +0100 (Sun, 24 Apr 2016)
#
#  https://github.com/harisekhon/Dockerfiles/hbase-dev
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

export JAVA_HOME="${JAVA_HOME:-/usr}"

# tries to run zookeepers.sh distributed via SSH, run zookeeper manually instead now
#RUN sed -i 's/# export HBASE_MANAGES_ZK=true/export HBASE_MANAGES_ZK=true/' /hbase/conf/hbase-env.sh
#$HBASE_HOME/bin/hbase zookeeper &
$HBASE_HOME/bin/start-hbase.sh
$HBASE_HOME/bin/hbase-daemon.sh start rest
#/hbase/bin/hbase-daemon.sh start thrift
$HBASE_HOME/bin/hbase-daemon.sh start thrift2

trap_func(){
    echo -e "\n\nShutting down HBase:"
    $HBASE_HOME/bin/stop-hbase.sh | grep -v "ssh: command not found"
    pkill -f org.apache.hadoop.hbase.zookeeper
    sleep 1
}
trap trap_func INT QUIT TRAP ABRT TERM EXIT

if [ -t 0 ]; then
    $HBASE_HOME/bin/hbase shell
else
    echo "
Running non-interactively, will not open HBase shell
For HBase shell start this image with 'docker run -t -i' switches
"
fi
# this doesn't Control-C , get's stuck
#tail -f /hbase/logs/*

# this shuts down from Control-C but exits prematurely, even when +euo pipefail and doesn't shut down HBase
# so I rely on the sig trap handler above
tail -f $HBASE_HOME/logs/* &
wait || :
