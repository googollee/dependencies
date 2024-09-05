#!/bin/bash
set -euo pipefail

: ${TARGETPLATFORM=linux/amd64}

TARGETOS="$(echo $TARGETPLATFORM | cut -d"/" -f1)"
TARGETARCH="$(echo $TARGETPLATFORM | cut -d"/" -f2)"
TARGETVARIANT="$(echo $TARGETPLATFORM | cut -d"/" -f3)"

function get_debian_arch() {
  arch=${1=amd64}
  variant=${2=}

  case "$arch" in
  "arm")
    case "$variant" in
    *)
      echo armhf
      ;;
    "5")
      echo armel
      ;;
    esac
    ;;
  *)
    echo $arch
    ;;
  esac
}

function get_compile_arch() {
  arch=${1=amd64}
  variant=${2=}

  case "$arch" in
  "amd64")
    echo "x86_64-linux-gnu"
    ;;
  "ppc64el")
    echo "powerpc64el-linux-gnu"
    ;;
  "s390x")
    echo "s390x-linux-gnu"
    ;;
  "arm64")
    echo "aarch64-linux-gnu"
    ;;
  "arm")
    case "$variant" in
    "5")
      echo "arm-linux-gnueabi"
      ;;
    *)
      echo "arm-linux-gnueabihf"
      ;;
    esac
    ;;
  "*")
    echo ""
    ;;
  esac
}

echo export HOST_COMPILER=$(get_compile_arch "$TARGETARCH" "$TARGETVARIANT") >>/env
echo export HOST_ARCH=$(get_debian_arch "$TARGETARCH" "$TARGETVARIANT") >>/env
cat /env
source /env

dpkg --add-architecture $HOST_ARCH
apt-get update
apt-get install -y git curl wget build-essential  crossbuild-essential-${HOST_ARCH} libc-dev:${HOST_ARCH} autoconf automake libtool m4 pkg-config cmake
