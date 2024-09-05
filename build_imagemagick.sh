#!/bin/bash
set -euo pipefail

apt-get install -y libjxl-dev libfftw3-dev liblcms2-dev liblqr-1-0-dev zlib1g-dev liblzma-dev libbz2-dev libdjvulibre-dev libexif-dev libjpeg-dev libopenjp2-7-dev libopenexr-dev libpng-dev libtiff-dev libwmf-dev libwebp-dev libxml2-dev
curl -s https://api.github.com/repos/ImageMagick/ImageMagick/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./magick.tar.gz
tar xfv ./magick.tar.gz
cd ImageMagick-*
./configure --enable-static --enable-delegate-build --disable-shared
make
make install
cd ..
