# ros2-cross-compiling

It's a toolchain to setup ros2 cross compiling.

## Prerequisites

Please check if your host ubuntu version is the same as your target ubuntu version.
Then, modify the distribution_version definition in tools/sysroot-rpi-ubuntu-arm64.toml to your ubuntu version as follows.
```
distribution_version = "jammy"
```

## Usage

1. create a sysroot by tools/create-sysroot.sh.
2. move tools/{cc.sh,generic-linux.cmake} to ros2 workspace.
3. setup multi-arch to add arm64 architecture to your host and this work is finished by tools/multi-arch/setup.sh. setup.sh not only setup the arm64 architecture to your host but also install libpython3.10-dev:arm64 which is needed by cross compiling. After setup the multi-arch, you can add more needed libraries by `sudo apt install [libpackage]:arm64`.
4. modify SYSROOT environment to yours.
5. run cc.sh to cross compile your ros2 workspace.
6. copy install.tar.gz to your target.

NOTE: you can use your target sysroot by sshfs, e.g.,
```bash
sshfs [user]@[host]:/ sysroot
```
