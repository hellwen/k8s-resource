#!/bin/sh

echo "### build starting ------------------"
docker build -t 10.0.12.203:32000/golang:1.7-onbuild .
echo "### build finished ------------------"
