#!/bin/bash

chmod 700 /root/.ssh

if [ ! -f /.root_pw_set ]; then
    /set_root_pw.sh
fi

exec /usr/sbin/sshd -D
