#!/usr/bin/env bash

set -eu

MAME_BUILD_PARALLELISM="${1:-2}"

export IMAGE_NAME=portable-mame
export IMAGE_TAG=latest

docker build \
  --platform linux/amd64 \
  --build-arg "MAME_BUILD_PARALLELISM=${MAME_BUILD_PARALLELISM}" \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

docker save "${IMAGE_NAME}:${IMAGE_TAG}" | gzip > portable-mame-image.tar.gz

LAYER_FILE="$(tar -xzf portable-mame-image.tar.gz manifest.json --to-stdout | jq -r '.[0].Layers[0]')"

tar -xf portable-mame-image.tar.gz "${LAYER_FILE}" --to-stdout | gzip > portable-mame.tar.gz

tar -tf portable-mame.tar.gz

rm -f portable-mame-image.tar.gz
