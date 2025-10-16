FROM ubuntu:jammy-20240627.1 AS base
# add unzip
RUN apt-get update && \
    apt-get install -y \
    unzip libpipewire-0.3-dev file libappindicator3-dev libwebkit2gtk-4.1-0 libgbm-dev libjavascriptcoregtk-4.1-0 libwebkit2gtk-4.1-dev \
    gir1.2-javascriptcoregtk-4.1 gir1.2-webkit2gtk-4.1 \
    libwebkit2gtk-4.0-dev libwebkit2gtk-4.1-dev build-essential curl wget \
    libssl-dev libgtk-3-dev libayatana-appindicator3-dev librsvg2-dev \
    jq tar bash libbrotli-dev brotli imagemagick git cmake

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /ci

FROM base