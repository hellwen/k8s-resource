#!/bin/bash

cd /root/.ssh
cat /.ssh/authorized_keys > authorized_keys
chmod 600 authorized_keys

if [ ! -f /.root_pw_set ]; then
    /set_root_pw.sh
fi

/usr/sbin/sshd
