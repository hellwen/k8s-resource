#!/bin/bash

cat << EOF > /etc/security/limits.d/99-mongodb-nproc.conf
*          soft    nproc     64000
*          hard    nproc     64000
EOF
