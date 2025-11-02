#!/usr/bin/env bash

set -eu

export USERNAME="$(whoami)"
export USER_UID="$(id -u)"
export USER_GID="$(id -g)"

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/home/${USERNAME}}/working"
export IMAGE_NAME=mpi-sandbox
export IMAGE_TAG=development

docker build \
  --build-arg USERNAME \
  --build-arg USER_UID \
  --build-arg USER_GID \
  --platform linux/amd64 \
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
