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
    jq tar bash libbrotli-dev brotli imagemagick git cmake unzip git-lfs \
    dbus dbus-user-session gnome-keyring libsecret-1-0 libsecret-tools xdg-utils sudo \
    && rm -rf /var/lib/apt/lists/*

# Non-root user; Secret Service won't run properly as root
RUN useradd -ms /bin/bash runner && echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Session bus runtime directory (UID 1000 for 'runner')
RUN mkdir -p /run/user/1000 && chown -R runner:runner /run/user/1000 && chmod 700 /run/user/1000
ENV XDG_RUNTIME_DIR=/run/user/1000

USER runner
ENV USER=runner
ENV HOME=/home/runner

# Rust toolchain (nightly as requested)
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
ENV PATH="/home/runner/.cargo/bin:${PATH}"

WORKDIR /ci

FROM base