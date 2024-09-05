#!/bin/bash
set -euo pipefail

mkdir -p ~/release/{lib,bin}
cp -a /usr/local/lib/{libheif.so*,libraw_r.so*} ~/release/lib/
cp /usr/local/bin/magick ~/release/bin/

mkdir -p ~/dev/lib/pkgconfig
cp -ar /usr/local/lib/libheif* ~/dev/lib/
cp -ar /usr/local/lib/pkgconfig/libheif* ~/dev/lib/pkgconfig
