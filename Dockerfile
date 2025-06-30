FROM --platform=${BUILDPLATFORM} debian AS builder

WORKDIR /root

ARG TARGETPLATFORM \
    BUILDPLATFORM \
    SNELL_SERVER_VERSION="5.0.0b1"

COPY *.sh /root/

RUN apt update && \
    apt install unzip wget -y && \
    bash ./download.sh ${TARGETPLATFORM} ${SNELL_SERVER_VERSION}

FROM debian:trixie-slim

WORKDIR /root
COPY --from=builder /root/snell-server /usr/bin/
COPY entrypoint.sh /root/
# Add Tini
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /tini
RUN chmod +x /tini

ENV PORT=6250 \
    IPV6=false \
    DNS=1.1.1.1,1.0.0.1 \
    PSK=

ENTRYPOINT ["/tini","--","/root/entrypoint.sh"]
