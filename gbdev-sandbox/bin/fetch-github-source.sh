#!/usr/bin/env sh

set -eu
set -o pipefail

if [ "${1}" = "--help" ]; then
  echo "Usage: fetch-github-source.sh ACCOUNT_NAME REPO_NAME TYPE LABEL SHA256 DOWNLOAD_DIR TARGET_DIR"
  exit 0
fi

ACCOUNT_NAME="${1}"
REPO_NAME="${2}"
TYPE="${3}"
LABEL="${4}"
SHA256="${5}"
DOWNLOAD_DIR="${6}"
TARGET_DIR="${7}"

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

curl -sSfLo "${DOWNLOAD_DIR}/source-${SHA256}.tar.gz" "${BASE_URL}/${LABEL}.tar.gz"
echo "${SHA256}  ${DOWNLOAD_DIR}/source-${SHA256}.tar.gz" > "${DOWNLOAD_DIR}/source-${SHA256}.sha256"
sha256sum -c "${DOWNLOAD_DIR}/source-${SHA256}.sha256"
mkdir "${TARGET_DIR}"
tar xzf "${DOWNLOAD_DIR}/source-${SHA256}.tar.gz" --strip-components=1 --directory "${TARGET_DIR}"
