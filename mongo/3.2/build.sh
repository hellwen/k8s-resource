#!/bin/sh

echo "### build starting ------------------"
docker build -t 10.0.12.203:32000/mongo:3.2.001 .
echo "### build finished ------------------"

echo "### push------------------"
docker push 10.0.12.203:32000/mongo:3.2.001
