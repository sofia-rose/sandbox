#!/usr/bin/env bash

set -eu
set -o pipefail

NS=default
POD_NAME="$(kubectl get pod \
  --namespace "${NS}" \
  --selector app=awscli-shell-deployment \
  --field-selector status.phase=Running \
  --output json \
  | jq -r '.items[0].metadata.name')"

exec kubectl exec -it \
  --namespace "${NS}" \
  "${POD_NAME}" \
  -- bash
