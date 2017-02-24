#!/bin/bash

if [ ! -f /.root_pw_set ]; then
    /set_root_pw.sh
fi

echo "########### running..."
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
