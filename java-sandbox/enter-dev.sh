#!/usr/bin/env bash

set -eu

export USERNAME="$(whoami)"
export USER_UID="$(id -u)"
export USER_GID="$(id -g)"

export HOST_WORKSPACE="${HOST_WORKSPACE:-$PWD}"
export CONTAINER_WORKSPACE="${CONTAINER_WORKSPACE:-/home/${USERNAME}/workspace}"
export IMAGE_NAME=java-sandbox
export IMAGE_TAG=development

export HOST_MAVEN_CONFIG="${HOST_MAVEN_CONFIG:-$PWD/.m2}"
export CONTAINER_MAVEN_CONFIG="${CONTAINER_MAVEN_CONFIG:-/home/${USERNAME}/.m2}"


docker build \
  --progress plain \
  --build-arg USERNAME \
  --build-arg USER_UID \
  --build-arg USER_GID \
  --platform linux/amd64 \
  --tag "${IMAGE_NAME}:${IMAGE_TAG}" \
  .

if [ ! -d "${HOST_MAVEN_CONFIG}" ]; then
  mkdir -p "${HOST_MAVEN_CONFIG}"
fi

docker run \
  --platform linux/amd64 \
  --interactive \
  --tty \
  --rm \
  --user "${USERNAME}" \
  --env "TERM=xterm-256color" \
  --env "MAVEN_CONFIG=${CONTAINER_MAVEN_CONFIG}" \
  --volume "${HOST_MAVEN_CONFIG}:${CONTAINER_MAVEN_CONFIG}" \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --workdir "${CONTAINER_WORKSPACE}" \
  "${IMAGE_NAME}:${IMAGE_TAG}" \
  bash
