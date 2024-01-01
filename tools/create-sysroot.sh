#!/usr/bin/env bash

cd .. && cargo build

echo "run target/debug/sysroot-creator sysroot-rpi-ubuntu-arm64.toml to create sysroot"
