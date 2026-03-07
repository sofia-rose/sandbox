#!/usr/bin/env sh

set -eu
set -o pipefail

BGB_VERSION=1.6.6
SHA256=38b97e4496ad85106f59c87a6b0386b7405fbebb3bccc90650279762bd10478c

DOWNLOAD_DIR="${1}"

mkdir -p "${DOWNLOAD_DIR}"
curl -sSfLo "${DOWNLOAD_DIR}/bgbw64.zip" https://bgb.bircd.org/bgbw64.zip
echo "${SHA256}  ${DOWNLOAD_DIR}/bgbw64.zip" > "${DOWNLOAD_DIR}/bgbw64.sha256"
sha256sum -c "${DOWNLOAD_DIR}/bgbw64.sha256"
cd "${DOWNLOAD_DIR}"
unzip bgbw64.zip
