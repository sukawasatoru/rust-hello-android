Use Rust on Android
===================

Usage
-----

```bash
docker run --rm --mount=type=bind,src=$PWD,dst=/work -w/work -u$(id -u):$(id -g) ghcr.io/sukawasatoru/toolchain-android-rust:1.0 make
```

refs.  
https://mozilla.github.io/firefox-browser-architecture/experiments/2017-09-21-rust-on-android.html  
https://developer.android.com/ndk/guides/other_build_systems  
https://doc.rust-lang.org/cargo/reference/config.html
