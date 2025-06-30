#!/usr/bin/env bash

set -eu

export USERNAME="$(whoami)"
export USER_UID="$(id -u)"
export USER_GID="$(id -g)"

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/home/${USERNAME}/workspace}"
export IMAGE_NAME=local/x86-64-sandbox
export IMAGE_TAG=development

docker build \
  --platform linux/amd64 \
  --build-arg USERNAME \
  --build-arg USER_UID \
  --build-arg USER_GID \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

docker run \
  --platform linux/amd64 \
  --interactive \
  --tty \
  --rm \
  --user "${USERNAME}" \
  --env TERM="xterm-256color" \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --workdir "${CONTAINER_WORKSPACE}" \
  "${IMAGE_NAME}:${IMAGE_TAG}" \
  bash
