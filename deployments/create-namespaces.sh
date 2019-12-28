#!/bin/sh
namespaces="monitoring logging falco harbor metallb minio traefik"
for namespace in $namespaces
do
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: $namespace
EOF
done