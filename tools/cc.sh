#!/bin/bash

THIS_FOLDER=$(dirname $(realpath $BASH_SOURCE))
echo "Assuming located here: ${THIS_FOLDER}"

export TARGET_ARCH=aarch64

export CROSS_COMPILER_C="aarch64-linux-gnu-gcc"
export CROSS_COMPILER_CXX="aarch64-linux-gnu-g++"

# XXX: must modify it to your sysroot
export SYSROOT="${THIS_FOLDER}/rpi-ubuntu-arm64-sysroot/sysroot"
export PYTHON_SOABI="cpython-310-aarch64-linux-gnu"

export TARGET_C_FLAGS=" -w -O2 -Wl,-rpath-link=/root/ws/install/lib"
export TARGET_CXX_FLAGS=" -w -O2 -Wl,-rpath-link=/root/ws/install/lib"

DO_COMPRESS="yes"

# Source rolling environment:
if [ -v ROS_DISTRO ]; then
    echo "Using host ROS distro: ${ROS_DISTRO}"
else
    echo "Sourcing rolling environment first: /opt/ros/rolling/local_setup.bash"
    source /opt/ros/rolling/local_setup.bash
fi

set -eu

cd ${THIS_FOLDER}

COLCON_WS=cross_ws

# Create a workspace, or keep existing one:
if [ -d ${COLCON_WS} ]; then
    echo "Using existing workspace: ${COLCON_WS}"
else
    echo "Creating workspace: ${COLCON_WS}"
    mkdir ${COLCON_WS}
    ln -s ${THIS_FOLDER}/src ${COLCON_WS}/src
fi

cd ${COLCON_WS}

# Select toolchain file:
CMAKE_TOOLCHAIN_FILE=${THIS_FOLDER}/generic-linux.cmake

colcon build --merge-install \
    --cmake-args -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}

# compress the install folder for usage on target:
if [ ${DO_COMPRESS} == "yes" ]; then
    tar zcf install.tar.gz install
fi

# Create app image file (seperate script?):
#APPIMAGETOOL=${THIS_FOLDER}/tools/appimagetool-x86_64.AppImage
#APPIMAGERUNTIME=${THIS_FOLDER}/tools/runtime-aarch64
#
#if [ -f ${APPIMAGETOOL} ]; then
#    cd ${THIS_FOLDER}
#
#    # Create some AppDir:
#    APPDIR_FOLDER=AppDir
#    if [ ! -d ${APPDIR_FOLDER} ]; then
#        mkdir ${APPDIR_FOLDER}
#    fi
#
#    # Add some helper scripts:
#    cp tools/appimage/{myapp.desktop,ros_icon.png,AppRun} ${APPDIR_FOLDER}/
#
#    # Insert colcon install folder:
#    cp -r ${COLCON_WS}/install ${APPDIR_FOLDER}/
#
#    # Create portable app:
#    ${APPIMAGETOOL} --runtime-file ${APPIMAGERUNTIME} ${APPDIR_FOLDER}
#else
#    echo "Not found: ${APPIMAGETOOL}, use ./download-app-image-tools.sh"
#fi

# Deploy:
#APPIMG=MyApp-aarch64.AppImage
