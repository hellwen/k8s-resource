#! /bin/sh

kubectl delete secret kube-registry-tls-certs
kubectl create secret generic kube-registry-tls-certs --from-file=./certs/domain-crt --from-file=./certs/domain-key
