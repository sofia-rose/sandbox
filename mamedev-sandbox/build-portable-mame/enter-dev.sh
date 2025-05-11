#!/usr/bin/env bash

set -eu

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/root/working}"
export IMAGE_NAME=mamedev-sandbox
export IMAGE_TAG=development

docker build \
  --platform linux/amd64 \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

docker run \
  --platform linux/amd64 \
  --interactive \
  --tty \
  --rm \
  --env TERM="xterm-256color" \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --workdir "${CONTAINER_WORKSPACE}" \
  "${IMAGE_NAME}:${IMAGE_TAG}" \
  bash
