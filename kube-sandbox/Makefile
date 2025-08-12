# TODO: make this dynamic?
HOST_OS ?= linux
HOST_ARCH ?= amd64

WGET ?= wget
LOCALBIN ?= $(shell pwd)/bin

KIND ?= $(LOCALBIN)/kind
KIND_DL_PREFIX ?= https://github.com/kubernetes-sigs/kind/releases/download
KIND_VERSION ?= v0.29.0
KIND_SHA256_FILE ?= kind.sha256

KUBECTL ?= $(LOCALBIN)/kubectl
KUBECTL_DL_PREFIX ?= https://dl.k8s.io/release
KUBECTL_VERSION ?= v1.33.0
KUBECTL_SHA256_FILE ?= kubectl.sha256

HELM ?= $(LOCALBIN)/helm
HELM_DL_PREFIX ?= https://get.helm.sh
HELM_VERSION ?= v3.17.4
HELM_SHA256_FILE ?= helm.sha256

.PHONY: all
all: kind kubectl helm

.PHONY: kind
kind: $(KIND)

$(KIND): $(KIND_SHA256_FILE) | $(LOCALBIN)
	$(WGET) "${KIND_DL_PREFIX}/${KIND_VERSION}/kind-${HOST_OS}-${HOST_ARCH}"
	sha256sum --check --ignore-missing "${KIND_SHA256_FILE}"
	mv "kind-${HOST_OS}-${HOST_ARCH}" $@
	touch $@
	chmod +x $@

$(KIND_SHA256_FILE):
	echo "c72eda46430f065fb45c5f70e7c957cc9209402ef309294821978677c8fb3284  kind-linux-amd64" > $@


.PHONY: kubectl
kubectl: $(KUBECTL)

$(KUBECTL): $(KUBECTL_SHA256_FILE) | $(LOCALBIN)
	$(WGET) -O "kubectl-${HOST_OS}-${HOST_ARCH}" "${KUBECTL_DL_PREFIX}/${KUBECTL_VERSION}/bin/${HOST_OS}/${HOST_ARCH}/kubectl"
	sha256sum --check --ignore-missing "${KUBECTL_SHA256_FILE}"
	mv "kubectl-${HOST_OS}-${HOST_ARCH}" $@
	touch $@
	chmod +x $@

$(KUBECTL_SHA256_FILE):
	echo "9efe8d3facb23e1618cba36fb1c4e15ac9dc3ed5a2c2e18109e4a66b2bac12dc  kubectl-linux-amd64" > $@


.PHONY: helm
helm: $(HELM)

$(HELM): $(HELM_SHA256_FILE) | $(LOCALBIN)
	$(WGET) "${HELM_DL_PREFIX}/helm-${HELM_VERSION}-${HOST_OS}-${HOST_ARCH}.tar.gz"
	sha256sum --check --ignore-missing "${HELM_SHA256_FILE}"
	tar xzf "helm-${HELM_VERSION}-${HOST_OS}-${HOST_ARCH}.tar.gz"
	rm "helm-${HELM_VERSION}-${HOST_OS}-${HOST_ARCH}.tar.gz"
	mv "${HOST_OS}-${HOST_ARCH}/helm" $@
	find "${HOST_OS}-${HOST_ARCH}" -type f -delete
	rmdir "${HOST_OS}-${HOST_ARCH}"
	touch $@
	chmod +x $@

$(HELM_SHA256_FILE):
	echo "c91e3d7293849eff3b4dc4ea7994c338bcc92f914864d38b5789bab18a1d775d  helm-${HELM_VERSION}-linux-amd64.tar.gz" > $@

$(LOCALBIN):
	mkdir -p $(LOCALBIN)

.PHONY: clean
clean:
	rm -f "${KIND_SHA256_FILE}"
	rm -f "${KIND}"
	rm -f "${KUBECTL_SHA256_FILE}"
	rm -f "${KUBECTL}"
	rm -f "${HELM_SHA256_FILE}"
	rm -f "${HELM}"
