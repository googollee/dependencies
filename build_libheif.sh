#!/bin/bash
set -euo pipefail

: ${HOST_COMPILER=x86_64-linux-gnu}
: ${HOST_ARCH=amd64}

echo Compiler: ${HOST_COMPILER} Arch: ${HOST_ARCH}

apt-get install -y libaom-dev:${HOST_ARCH} libavcodec-dev:${HOST_ARCH} libdav1d-dev:${HOST_ARCH} libde265-dev:${HOST_ARCH} libgdk-pixbuf-2.0-dev:${HOST_ARCH} libjpeg-dev:${HOST_ARCH} libopenjp2-7-dev:${HOST_ARCH} libpng-dev:${HOST_ARCH} librav1e-dev:${HOST_ARCH} libsvtav1enc-dev:${HOST_ARCH} libx265-dev:${HOST_ARCH}
curl -s https://api.github.com/repos/strukturag/libheif/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./libheif.tar.gz
tar xfv ./libheif.tar.gz
cd *-libheif-*
cmake --preset=release -DCMAKE_SYSTEM_PROCESSOR=${HOST_ARCH} -DCMAKE_C_COMPILER=${HOST_COMPILER}-gcc -DCMAKE_CXX_COMPILER=${HOST_COMPILER}-g++ -DPKG_CONFIG_EXECUTABLE=${HOST_COMPILER}-pkg-config -DCMAKE_LIBRARY_ARCHITECTURE=${HOST_COMPILER} -DPLUGIN_DIRECTORY=/usr/lib/${HOST_COMPILER}/libheif/plugins .
make
make install
cd ..
