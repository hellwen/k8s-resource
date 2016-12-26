#!/bin/bash

su - app -c "kill `cat /data/kibana/pid`"
