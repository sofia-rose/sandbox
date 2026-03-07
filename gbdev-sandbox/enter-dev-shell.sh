#!/usr/bin/env sh

set -eu

if [ "${DEV_SHELL:-x}" = true ]; then
  echo "DEV_SHELL environment variable set to 'true', aleady in a dev shell! Will not spawn another dev shell."
  exit 0
fi

export PROJECT_NAME="$(basename "${PWD}")"

export DEV_SHELL=true

export USERNAME="$(whoami)"
export USER_UID="$(id -u)"
export USER_GID="$(id -g)"

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/home/${USERNAME}/workspace}"
export IMAGE_NAME="${PROJECT_NAME}"
export IMAGE_TAG=dev-shell
export PLATFORM=linux/amd64

docker build \
  --target dev-shell \
  --progress plain \
  --build-arg USERNAME \
  --build-arg USER_UID \
  --build-arg USER_GID \
  --platform "${PLATFORM}" \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

docker run \
  --platform "${PLATFORM}" \
  --interactive \
  --tty \
  --rm \
  --user "${USERNAME}" \
  --env TERM=xterm-256color \
  --env SHELL=bash \
  --env DEV_SHELL=true \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --workdir "${CONTAINER_WORKSPACE}" \
  "${IMAGE_NAME}:${IMAGE_TAG}" \
  bash
