#!/bin/sh

echo "### build starting ------------------"
docker build -t 10.0.12.203:32000/kafka:2.11.001 .
echo "### build finished ------------------"

echo "### push------------------"
docker push 10.0.12.203:32000/kafka:2.11.001
