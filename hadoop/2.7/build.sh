#!/bin/sh

docker build -t 10.0.12.203:32000/hadoop-2.7 .
docker tag 10.0.12.203:32000/hadoop-2.7 10.0.12.203:32000/hadoop-2.7:0.2

docker push 10.0.12.203:32000/hadoop-2.7
docker push 10.0.12.203:32000/hadoop-2.7:0.2
