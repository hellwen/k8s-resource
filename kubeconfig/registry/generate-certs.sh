#! /bin/sh

mkdir -p certs
rm -rf certs/*

DOMAIN="k8s-registry.zeusis.com"

openssl req -newkey rsa:2048 -nodes -sha256 -keyout certs/domain-key -subj "/CN=${DOMAIN}" -x509 -days 365 -out certs/domain-crt
cp certs/domain-crt certs/ca.crt
