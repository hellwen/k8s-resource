#! /bin/bash

# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script configures zookeeper cluster member ship for version of zookeeper
# < 3.5.0. It should not be used with the on-start.sh script in this example.
# As of April-2016 is 3.4.8 is the latest stable.

CFG=$ZK_HOME/conf/zoo.cfg
CFG_BAK=$ZK_HOME/conf/zoo.cfg.bak
MY_ID=/data/zk/data/myid

# write myid
IFS='-' read -ra ADDR <<< "$(hostname)"
echo $(expr "1" + "${ADDR[1]}") > "${MY_ID}"

# TODO: This is a dumb way to reconfigure zookeeper because it allows dynamic
# reconfig, but it's simple.
/usr/local/on-init.sh

i=0
while read -ra LINE; do
    let i=i+1
    IP=${LINE#*,}
    DNS=${LINE%%,*}
    HOST=${LINE%%.*}

    echo "server.${i}=${DNS}:2191:2192" >> "${CFG_BAK}"
done
cp ${CFG_BAK} ${CFG}

# TODO: Typically one needs to first add a new member as an "observer" then
# promote it to "participant", but that requirement is relaxed if we never
# start > 1 at a time.
$ZK_HOME/bin/zkServer.sh restart
