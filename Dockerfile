FROM ubuntu:24.04 AS base
# add unzip
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    wget \
    file \
    clang \
    libssl-dev \
    libgtk-3-dev \
    librsvg2-dev \
    libwebkit2gtk-4.1-0 \
    libwebkit2gtk-4.1-dev \
    libgbm-dev \
    libjavascriptcoregtk-4.1-0 \
    libjavascriptcoregtk-4.1-dev \
    gir1.2-javascriptcoregtk-4.1 \
    gir1.2-webkit2-4.1 \
    libpipewire-0.3-dev \
    libayatana-appindicator3-dev \
    jq tar bash libbrotli-dev brotli imagemagick git cmake \
    unzip git-lfs

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /ci

FROM base