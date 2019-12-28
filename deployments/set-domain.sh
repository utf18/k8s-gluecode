#!/bin/bash

# set domain in charts and eck for the kibana ingress
find charts -name "values.yaml" -exec sed -i '' "s/my-domain/cloud.lab/g" '{}' \;

find eck -name "kibana.yml" -exec sed -i '' "s/my-domain/cloud.lab/g" '{}' \;