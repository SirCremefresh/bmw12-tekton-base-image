FROM ubuntu:20.04
LABEL maintainer="<donato@wolfisberg.dev>"
LABEL maintainer_name="Donato Wolfisberg"

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

# Note: Latest version of kubectl can be found at:
# https://github.com/kubernetes/kubernetes/releases
ENV KUBE_VERSION="v1.19.3"
# Note: Latest version of helm can be found at
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v3.4.0"
# Note: Latest version of yq can be found at
# https://github.com/mikefarah/yq/releases
ENV YQ_VERSION="3.4.1"

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        wget \
        git \
        jq \
        openssl \
        gnupg \
        tar \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && wget -q \
        https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
        -O /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && wget -q \
        https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl \
        -O /usr/bin/kubectl \
    && chmod +x /usr/bin/kubectl \
    && wget -q \
        https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - \
        | tar -xzO linux-amd64/helm > /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/cache/apt/archives/* \
        /var/lib/apt/lists/*
