################################################################################
.PHONY: install-localstack
install-localstack: add-localstack-helm-repo
	helm upgrade \
		--install \
		--create-namespace \
		--namespace localstack \
		--version 0.6.24 \
		--set service.type=ClusterIP \
		localstack localstack-charts/localstack

.PHONY: add-localstack-helm-repo
add-localstack-helm-repo:
	helm repo add localstack-charts https://localstack.github.io/helm-charts
	helm repo update

.PHONY: remove-localstack
remove-localstack:
	helm uninstall --namespace localstack localstack
################################################################################


################################################################################
IMAGE_NAME ?= localhost:5001/ack-bootstap
IMAGE_TAG ?= development

.PHONY: build-and-push-awscli-image
build-and-push-awscli-image: bootstrap/Dockerfile
	docker build --tag "${IMAGE_NAME}:${IMAGE_TAG}" bootstrap
	docker push "${IMAGE_NAME}:${IMAGE_TAG}"

.PHONY: apply-awscli-shell-deployment
apply-awscli-shell-deployment: build-and-push-awscli-image
	kubectl apply -f awscli-shell-deployment.yaml

.PHONY: delete-awscli-shell-deployment
delete-awscli-shell-deployment:
	kubectl delete -f awscli-shell-deployment.yaml

.PHONY: enter-awscli-shell
enter-awscli-shell: apply-awscli-shell-deployment build-and-push-awscli-image
	./enter-awscli-shell.sh
################################################################################


################################################################################
################################################################################

################################################################################
.PHONY: ack-system-namespace
ack-system-namespace:
	kubectl create namespace ack-system || true

.PHONY: ack-iam-controller-creds-secret
ack-iam-controller-creds-secret: ack-system-namespace
	kubectl create secret -n ack-system generic ack-iam-controller-credentials \
		--from-literal "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
		--from-literal "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"

.PHONY: install-ack-iam-controller
install-ack-iam-controller:
	helm upgrade \
		--install \
		--create-namespace \
		--namespace ack-system \
		--version 1.5.0 \
		--values ack-iam-controller-values.yaml \
		ack-iam-controller \
		oci://public.ecr.aws/aws-controllers-k8s/iam-chart

.PHONY: remove-ack-iam-controller
remove-ack-iam-controller:
	helm uninstall --namespace ack-system ack-iam-controller
################################################################################

################################################################################
.PHONY: install-ack-controller-iam-users
install-ack-controller-iam-users:
	kubectl apply -f ack-controller-iam-users.yaml

.PHONY: remove-ack-controller-iam-users
remove-ack-controller-iam-users:
	kubectl delete -f ack-controller-iam-users.yaml
################################################################################

################################################################################
################################################################################
