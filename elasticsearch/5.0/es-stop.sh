#!/bin/bash

# stop es
cd $ES_HOME/logs/
kill `cat pid`
