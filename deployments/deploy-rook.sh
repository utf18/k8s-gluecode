#!/bin/bash

kubectl apply -f rook/common.yml
kubectl apply -f rook/operator.yml
# wait here at least 60 seconds
echo "sleeping for 120 seconds to make sure everything is running"
sleep 120

kubectl apply -f rook/cluster.yml
echo "sleeping for 300 seconds to wait until the cluster is ready"
sleep 300
kubectl apply -f rook/storageclass.yml

echo "make sure all pods in rook-ceph namespace are running before deploying workload"