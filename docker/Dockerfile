# syntax=docker/dockerfile:1.3

FROM ubuntu:24.04 AS prepare-curl
RUN rm /etc/apt/apt.conf.d/docker-clean && \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt \
  apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  unzip

FROM prepare-curl AS rust
SHELL ["/bin/bash", "-c"]
ARG RUST_VERSION
ENV CARGO_HOME=/opt/cargo
ENV PATH=$CARGO_HOME/bin:$PATH
ENV RUSTUP_HOME=/opt/rustup
RUN set -o pipefail && \
  curl -sSf https://sh.rustup.rs | bash -s -- -v -y --no-modify-path --default-toolchain $RUST_VERSION -t \
  aarch64-linux-android \
  arm-linux-androideabi \
  armv7-linux-androideabi \
  i686-linux-android \
  thumbv7neon-linux-androideabi \
  x86_64-linux-android

FROM ghcr.io/sukawasatoru/toolchain-android:1.2
ENV CARGO_HOME=/opt/cargo
ENV PATH=$CARGO_HOME/bin:$PATH
ENV RUSTUP_HOME=/opt/rustup
COPY --from=rust $CARGO_HOME $CARGO_HOME
COPY --from=rust $RUSTUP_HOME $RUSTUP_HOME
RUN chmod -R a+w $CARGO_HOME $RUSTUP_HOME

LABEL org.opencontainers.image.source=https://github.com/sukawasatoru/rust-hello-android
