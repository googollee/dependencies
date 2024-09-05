#!/bin/bash
set -euo pipefail

apt-get install -y libaom-dev libavcodec-dev libdav1d-dev libde265-dev libgdk-pixbuf-2.0-dev libjpeg-dev libopenjp2-7-dev libpng-dev librav1e-dev libsvtav1enc-dev libx265-dev
curl -s https://api.github.com/repos/strukturag/libheif/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./libheif.tar.gz
tar xfv ./libheif.tar.gz
cd *-libheif-*
cmake --preset=release .
make
make install
cd ..
