#!/usr/bin/env bash

set -eu

POLICY_JSON_FILE="${1:-/ack-bootstrap/iam-controller-inline-policy.json}"

ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
USER_NAME="ack-iam-controller-user"
POLICY_NAME="${USER_NAME}-policy"
POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/${POLICY_NAME}"

echo "ACCOUNT_ID: ${ACCOUNT_ID}"
echo "USER_NAME: ${USER_NAME}"
echo "POLICY_NAME: ${POLICY_NAME}"
echo "POLICY_ARN: ${POLICY_ARN}"

policy_exists()
{
  aws iam get-policy --policy-arn "${POLICY_ARN}"
}

user_exists()
{
  aws iam get-user --user-name "${USER_NAME}"
}

if [ ! policy_exists ]; then
  aws iam create-policy \
    --policy-name "${POLICY_NAME}" \
    --policy-document "file://${POLICY_JSON_FILE}"
else
  echo "Policy '${POLICY_NAME}' already exists!"
fi

if [ ! user_exists ]; then
  aws iam create-user \
    --user-name "${USER_NAME}"

  aws iam attach-user-policy \
    --user-name "${USER_NAME}" \
    --policy-arn "${POLICY_ARN}"
else
  echo "User '${USER_NAME}' already exists!"
fi

KEY="$(aws iam create-access-key \
  --user-name "${USER_NAME}" \
  --query 'AccessKey.[AccessKeyId,SecretAccessKey]' --output json)"

AWS_ACCESS_KEY_ID="$(echo "${KEY}" | jq -r '.[0]')"
AWS_SECRET_ACCESS_KEY="$(echo "${KEY}" | jq -r '.[1]')"

echo "AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}"
echo "AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}"
