#!/bin/bash

pushd charts-templated
for chart in *; do
  kubectl apply -k ${chart}/base
done
popd