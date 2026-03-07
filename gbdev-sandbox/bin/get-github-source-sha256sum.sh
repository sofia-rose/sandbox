#!/usr/bin/env sh

set -eu
set -o pipefail

if [ "${1}" = "--help" ]; then
  echo "Usage: get-github-source-sha256.sh ACCOUNT_NAME REPO_NAME TYPE LABEL DOWNLOAD_DIR"
  exit 0
fi

ACCOUNT_NAME="${1}"
REPO_NAME="${2}"
TYPE="${3}"
LABEL="${4}"
DOWNLOAD_DIR="${5}"

BASE_URL=unknown

if [ "${TYPE}" = branch ]; then
  BASE_URL="https://github.com/${ACCOUNT_NAME}/${REPO_NAME}/archive/refs/heads"
elif [ "${TYPE}" = tag ]; then
  BASE_URL="https://github.com/${ACCOUNT_NAME}/${REPO_NAME}/archive/refs/tags"
elif [ "${TYPE}" = commit ]; then
  BASE_URL="https://github.com/${ACCOUNT_NAME}/${REPO_NAME}/archive"
else
  echo "Unknown type of archive: ${TYPE}"
  exit -1
fi

curl -sSfLo "${DOWNLOAD_DIR}/source.tar.gz" "${BASE_URL}/${LABEL}.tar.gz"
sha256sum "${DOWNLOAD_DIR}/source.tar.gz"
