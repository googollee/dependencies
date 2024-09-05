#!/bin/bash
set -euo pipefail

apt-get install -y zlib1g-dev liblcms2-dev libjpeg-dev
curl -s https://api.github.com/repos/LibRaw/LibRaw/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./libraw.tar.gz
tar xfv ./libraw.tar.gz
cd LibRaw-*
autoreconf --install
./configure
make
make install
cd ..
