#!/bin/bash

# create neccesary folder in charts-templated
# create kustomization.yml's in each folder
# create helm templates for later use with kustomize in a subfolder for each file
pushd charts
for chart in *; do
  mkdir -p ../charts-templated/${chart}/base
  cat << EOF >  ../charts-templated/${chart}/base/kustomization.yml
  resources:
  - ${chart}-templated.yml
  namespace: ${chart}
EOF
  helm template ${chart} ${chart}/ -f ${chart}/values.yaml > ../charts-templated/${chart}/base/${chart}-templated.yml
done