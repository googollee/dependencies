#!/bin/bash
set -euo pipefail

apt-get update
apt-get install -y git curl wget build-essential autoconf automake libtool m4 pkg-config cmake
