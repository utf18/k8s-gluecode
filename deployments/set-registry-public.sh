#!/bin/bash

echo "removing the harbor registry prefix for all images"

find . -name "*.yaml" -exec sed -i '' "s|harbor.cloud.lab/public/||g" '{}' \;
find . -name "*.yml" -exec sed -i '' "s|harbor.cloud.lab/public/||g" '{}' \;