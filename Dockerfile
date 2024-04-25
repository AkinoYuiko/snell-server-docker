FROM --platform=${BUILDPLATFORM} alpine AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG SNELL_SERVER_VERSION="4.0.1"

RUN apk add wget unzip bash

WORKDIR /root

COPY download.sh .
RUN bash ./download.sh ${TARGETPLATFORM}

FROM --platform=${TARGETPLATFORM} angribot/glibc-alpine AS snell-server
ENV PORT=6250 \
    IPV6=false \
    PSK=
COPY --from=builder /root/snell-server /usr/bin/
COPY entrypoint.sh /root/
ENTRYPOINT ["/sbin/tini","--","/root/entrypoint.sh"]
