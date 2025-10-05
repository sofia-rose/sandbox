#!/usr/bin/env bash

set -eu

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/workspace}"
export IMAGE_NAME=dyalog/dyalog
export IMAGE_TAG=19.0

docker run \
  --platform linux/amd64 \
  --env 'RIDE_INIT=http:*:8888' \
  --publish '8888:8888' \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --rm \
  "${IMAGE_NAME}:${IMAGE_TAG}"
