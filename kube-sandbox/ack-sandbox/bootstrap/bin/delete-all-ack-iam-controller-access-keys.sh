#!/usr/bin/env bash

set -eu

USER_NAME="ack-iam-controller-user"

aws iam list-access-keys \
  --user-name "${USER_NAME}" \
  --query 'AccessKeyMetadata[].AccessKeyId' \
  --output json \
  | jq -r '.[]' \
  | xargs -n 1 aws iam delete-access-key \
    --user-name "${USER_NAME}" \
    --access-key-id
