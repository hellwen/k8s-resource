#!/bin/sh

echo "### build starting ------------------"
docker build -t 10.0.12.203:32000/push-logic:v1 .
echo "### build finished ------------------"

echo "### push------------------"
docker push 10.0.12.203:32000/push-logic:v1
