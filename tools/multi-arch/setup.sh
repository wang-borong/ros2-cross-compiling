#!/usr/bin/env bash

sudo dpkg --add-architecture arm64
sudo cp arm-cross-compile-sources.list /etc/apt/sources.list.d

if [[ -z $(grep -s "deb \[arch=amd64\]" /etc/apt/sources.list) ]]; then
    sudo sed -i 's/deb /deb \[arch=amd64\] /' /etc/apt/sources.list
fi
sudo apt update

sudo apt install libpython3.10-dev:arm64
