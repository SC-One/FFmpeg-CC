#!/bin/bash
export ANDROID_NDK_HOME=$1
FFMPEG_DIR=FFmpeg
SingleOption=$3
OUTPUT_DIR=output
git clean -f # install git! no time to fix now :/
toolchains_path=$(python toolchains_path.py --ndk ${ANDROID_NDK_HOME})
CC=clang
# Add toolchains bin directory to PATH
PATH=$toolchains_path/bin:$PATH
ANDROID_API=21

# Set the target architecture
# Can be armeabi-v7a , arm64-v8a, x86 , x86_64, etc
if [ -z "$2" ]
  then
    architecture=x86_64
else
    architecture=$2
fi

# Create the make file
cd ${OPENSSL_DIR}

./configure \
--prefix=${output}/${architecture}\ \
--enable-cross-compile \
--target-os=android \
--arch=${architecture} \ #--sysroot=${SYSROOT} \ #--cross-prefix=${CROSS_PREFIX} \
--cc=${CC} \
--extra-cflags="-O3 -fPIC" \
--enable-shared \
--disable-static \
${SingleOption} \


# Build
make -j$(nproc)
