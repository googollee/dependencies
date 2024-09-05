FROM debian:bookworm

# See for details: https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN mkdir -p /tmp/build
COPY build.sh /tmp/build/
RUN chmod +x /tmp/build/build.sh
RUN cd /tmp/build && \
    ./build.sh && \
    # Remove build dependencies and cleanup
    apt-get clean && \
    rm -Rf /tmp/build/* && \
    rm -rf /var/lib/apt/lists/*

COPY output.sh /
RUN /output.sh
