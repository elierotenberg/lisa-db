#!/bin/sh

docker run --rm -v "${PWD}:/local" openapitools/openapi-generator-cli generate \
  -i /local/directus.spec.json \
  -g python \
  --skip-validate-spec \
  -o /local/openapi \
