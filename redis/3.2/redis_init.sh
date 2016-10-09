#!/bin/bash

sed -i '/^bind/ s:.*:bind 0.0.0.0:' $REDIS_HOME/redis.conf
sed -i '/^protected-mode/ s:.*:protected-mode no:' $REDIS_HOME/redis.conf
