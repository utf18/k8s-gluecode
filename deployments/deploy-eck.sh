#!/bin/bash

kubectl apply -f eck/operator.yml
# wait a minute for elastic operator
# this should be a loop with actual check against running operator pod
echo "sleeping for 60 seconds to give the operator time to start"
sleep 60

kubectl apply -f eck/elasticsearch.yml
sleep 60
# make sure elastic is up and running, seems still buggy with the operator
kubectl apply -f eck/kibana.yml
kubectl apply -f eck/filebeat.yml