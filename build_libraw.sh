#!/bin/bash
set -euo pipefail

: ${HOST_COMPILER=x86_64-linux-gnu}
: ${HOST_ARCH=amd64}

echo Compiler: ${HOST_COMPILER} Arch: ${HOST_ARCH}

apt-get install -y zlib1g-dev:${HOST_ARCH} liblcms2-dev:${HOST_ARCH} libjpeg-dev:${HOST_ARCH}
curl -s https://api.github.com/repos/LibRaw/LibRaw/releases/latest | grep "tarball_url" | cut -d : -f 2,3 | tr -d ' ,"' | wget -i - -O ./libraw.tar.gz
tar xfv ./libraw.tar.gz
cd LibRaw-*
autoreconf --install
./configure --disable-option-checking --disable-silent-rules --disable-maintainer-mode --disable-dependency-tracking --host=${HOST_COMPILER}
make
make install
cd ..
