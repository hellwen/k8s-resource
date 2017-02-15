#!/bin/bash

cd /root/.ssh
cat /.ssh/authorized_keys > authorized_keys
chmod 600 authorized_keys

if [ ! -f /.root_pw_set ]; then
    /set_root_pw.sh
fi

/usr/sbin/sshd

echo "########### running..."
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
