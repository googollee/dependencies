#!/bin/bash
set -euo pipefail

: ${HOST_COMPILER=x86_64-linux-gnu}
: ${HOST_ARCH=amd64}

echo Compiler: ${HOST_COMPILER} Arch: ${HOST_ARCH}

apt-get install -y libjxl-dev:${HOST_ARCH} libfftw3-dev:${HOST_ARCH} liblcms2-dev:${HOST_ARCH} liblqr-1-0-dev:${HOST_ARCH} zlib1g-dev:${HOST_ARCH} liblzma-dev:${HOST_ARCH} libbz2-dev:${HOST_ARCH} libdjvulibre-dev:${HOST_ARCH} libexif-dev:${HOST_ARCH} libjpeg-dev:${HOST_ARCH} libopenjp2-7-dev:${HOST_ARCH} libopenexr-dev:${HOST_ARCH} libpng-dev:${HOST_ARCH} libtiff-dev:${HOST_ARCH} libwmf-dev:${HOST_ARCH} libwebp-dev:${HOST_ARCH} libxml2-dev:${HOST_ARCH}
curl -s https://api.github.com/repos/ImageMagick/ImageMagick/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./magick.tar.gz
tar xfv ./magick.tar.gz
cd ImageMagick-*
./configure --enable-static --enable-delegate-build --disable-shared --host=${HOST_COMPILER}
make
make install
cd ..
