FROM ubuntu:20.04
LABEL maintainer="<donato@wolfisberg.dev>"
LABEL maintainer_name="Donato Wolfisberg"

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        git \
        jq \
        openssl \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && wget \
        https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64 \
        -O /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/cache/apt/archives/* \
        /var/lib/apt/lists/*
