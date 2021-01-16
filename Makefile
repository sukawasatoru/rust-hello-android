SHELL=/bin/bash
.SUFFIXES:
CARGO=cargo

API=28
UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
    NDK=/opt/android-sdk-linux/ndk/22.0.7026061
    TOOLCHAIN=$(NDK)/toolchains/llvm/prebuilt/linux-x86_64
endif
ifeq ($(UNAME_S),Darwin)
    NDK=/opt/android-sdk-macosx/ndk/22.0.7026061
    TOOLCHAIN=$(NDK)/toolchains/llvm/prebuilt/darwin-x86_64
endif
export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_AR=$(TOOLCHAIN)/bin/arm-linux-androideabi-ar
export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=$(TOOLCHAIN)/bin/armv7a-linux-androideabi$(API)-clang
export CARGO_TARGET_X86_64_LINUX_ANDROID_AR=$(TOOLCHAIN)/bin/x86_64-linux-android-ar
export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER=$(TOOLCHAIN)/bin/x86_64-linux-android$(API)-clang

.PHONY: debug
debug:
	$(CARGO) build --target x86_64-linux-android
	$(CARGO) build --target armv7-linux-androideabi

.PHONY: release
release:
	$(CARGO) build --release --target x86_64-linux-android
	$(CARGO) build --release --target armv7-linux-androideabi

.PHONY: clean
clean:
	$(CARGO) clean

BUILD_DOCKER_LABEL=latest
.PHONY: build-docker
build-docker:
	cd docker && docker build --build-arg RUST_VERSION=1.49.0 -t ghcr.io/sukawasatoru/toolchain-android-rust:$(BUILD_DOCKER_LABEL) .
