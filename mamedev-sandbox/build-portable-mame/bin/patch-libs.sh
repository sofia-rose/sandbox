#!/usr/bin/env bash

set -euo pipefail

DIR="${1}"

find "${DIR}" -type f -name '*.so*' | while read -r lib; do
  patchelf --set-rpath '$ORIGIN' "${lib}"
done
