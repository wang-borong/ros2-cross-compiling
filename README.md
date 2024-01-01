# ros2-cross-compiling

## Usage

1. create a sysroot by tools/create-sysroot.sh.
2. move tools/{cc.sh,generic-linux.cmake} to ros2 workspace.
3. modify SYSROOT environment to yours.
4. run cc.sh to cross compile your ros2 workspace.
5. copy install.tar.gz to your target.

NOTE: you can use your target sysroot by sshfs, e.g.,
```bash
sshfs [user]@[host]:/ sysroot
```
