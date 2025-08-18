FROM public.ecr.aws/aws-cli/aws-cli:2.28.11

WORKDIR /ack-bootstrap

COPY iam-controller-inline-policy.json iam-controller-inline-policy.json
COPY bashrc.sh /root/.bashrc

COPY bin /usr/local/bin
