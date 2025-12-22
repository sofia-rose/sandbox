#!/usr/bin/env bash

set -eu

USERNAME=ubuntu

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/home/${USERNAME}/workspace}"
export IMAGE_NAME=cuda-sandbox
export IMAGE_TAG=development

docker build \
  --progress plain \
  --platform linux/amd64 \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

docker run \
  --platform linux/amd64 \
  --interactive \
  --tty \
  --rm \
  --runtime nvidia \
  --gpus all \
  --user "${USERNAME}" \
  --env TERM="xterm-256color" \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --workdir "${CONTAINER_WORKSPACE}" \
  "${IMAGE_NAME}:${IMAGE_TAG}" \
  bash
