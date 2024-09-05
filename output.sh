#!/bin/bash
set -euo pipefail

mkdir -p /output/{lib,bin,include}
cp -a /usr/local/lib/{libheif*,libraw_r*} /output/lib/
cp -a /usr/local/include/{libheif,libraw} /output/include/
cp /usr/local/bin/magick /output/bin/
