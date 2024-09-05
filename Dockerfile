FROM --platform=${BUILDPLATFORM:-linux/amd64} debian:bookworm AS build
ARG TARGETPLATFORM

# See for details: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN mkdir -p /tmp/build
WORKDIR /tmp/build

COPY prepare.sh /tmp/build/
RUN ./prepare.sh

COPY build_libraw.sh /tmp/build/
RUN source /env && ./build_libraw.sh
COPY build_libheif.sh /tmp/build/
RUN source /env && ./build_libheif.sh
COPY build_imagemagick.sh /tmp/build/
RUN source /env && ./build_imagemagick.sh

WORKDIR /
COPY output.sh /
RUN /output.sh

FROM debian:bookworm-slim AS release
COPY --from=build /output /output
