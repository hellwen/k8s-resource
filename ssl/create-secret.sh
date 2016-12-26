#! /bin/sh

kubectl delete secret ssh-key
kubectl create secret generic ssh-key --from-file=./authorized-keys --from-file=./id-rsa --from-file=./id-rsa.pub
