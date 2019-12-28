#!/bin/bash

kubectl apply -f rook/common.yml
kubectl apply -f rook/operator.yml
# wait here at least 60 seconds
sleep 60

kubectl apply -f rook/cluster.yml
kubectl apply -f rook/storageclass.yml

echo "make sure all pods in rook namespace are running before deploying workload"
watch kubectl get pods -n rook-veph