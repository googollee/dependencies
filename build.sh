#!/bin/bash
set -euo pipefail

apt-get update
apt-get install -y git curl wget build-essential autoconf automake libtool m4 pkg-config cmake

apt-get install -y zlib1g-dev liblcms2-dev libjpeg-dev
curl -s https://api.github.com/repos/LibRaw/LibRaw/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./libraw.tar.gz
tar xfv ./libraw.tar.gz
cd LibRaw-*
autoreconf --install
./configure
make
make install
cd ..

apt-get install -y libpng-dev libtiff-dev libde265-dev libdav1d-dev
curl -s https://api.github.com/repos/strukturag/libheif/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./libheif.tar.gz
tar xfv ./libheif.tar.gz
cd *-libheif-*
cmake --preset=release .
make
make install
cd ..

apt-get install -y libjxl-dev
curl -s https://api.github.com/repos/ImageMagick/ImageMagick/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./magick.tar.gz
tar xfv ./magick.tar.gz
cd ImageMagick-*
./configure --enable-static --enable-delegate-build --disable-shared
make
make install
cd ..
