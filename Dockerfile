FROM debian:bookworm

# See for details: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN mkdir -p /tmp/build
WORKDIR /tmp/build

COPY prepare.sh /tmp/build/
RUN ./prepare.sh

COPY build_libraw.sh /tmp/build/
RUN ./build_libraw.sh
COPY build_libheif.sh /tmp/build/
RUN ./build_libheif.sh
COPY build_imagemagick.sh /tmp/build/
RUN ./build_imagemagick.sh

# Remove build dependencies and cleanup
# RUN rm -Rf /tmp/build/*
RUN apt-get clean && rm -rf /var/lib/apt/lists/* 

WORKDIR /
COPY output.sh /
RUN /output.sh
