#!/usr/bin/env bash

set -euo pipefail

ELF_FILE="${1}"
TARGET_PATH="${2}"

mkdir -p "${TARGET_PATH}"

ldd "${ELF_FILE}" | grep '=>' | awk '{print $3}' | while read -r lib; do
  echo "Copying ${lib} to ${TARGET_PATH}"
  cp "${lib}" "${TARGET_PATH}/"
done
