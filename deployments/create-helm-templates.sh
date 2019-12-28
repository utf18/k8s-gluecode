#!/bin/bash

# create neccesary folder in charts-templated
# create kustomization.yml's in each folder
# create helm templates for later use with kustomize in a subfolder for each file
pushd charts
for chart in *; do
  # override namespace for grafana,prometheus etc..
  case $chart in
  grafana)
    namespace=monitoring
    ;;
  prometheus)
    namespace=monitoring
    ;;
  metrics-server)
    namespace=kube-system
    ;;
  kube-state-metrics)
    namespace=kube-system
    ;;
  # default namespace name is chart/folder name
  *)
    namespace=${chart}
    ;;
  esac
  
  # create folder structure
  mkdir -p ../charts-templated/${chart}/base

  # create base kustomization yaml
  cat << EOF >  ../charts-templated/${chart}/base/kustomization.yml
resources:
- ${chart}-templated.yml
namespace: ${namespace}
EOF
  # helm template the charts and write them to the created folder structure in charts-templated
  helm template ${chart} --namespace ${namespace} ${chart}/ -f ${chart}/values.yaml > ../charts-templated/${chart}/base/${chart}-templated.yml
done