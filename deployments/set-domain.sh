#!/bin/bash

# set domain in charts and eck for the kibana ingress
find charts -name "values.yaml" -exec sed -i '' "s/cloud.lab/$1/g" '{}' \;

find eck -name "kibana.yml" -exec sed -i '' "s/cloud.lab/$1/g" '{}' \;