FROM --platform=${BUILDPLATFORM} alpine

WORKDIR /root

ARG TARGETPLATFORM \
    BUILDPLATFORM \
    GLIBC_VERSION="2.36-r1" \
    SNELL_SERVER_VERSION="4.1.1"

COPY *.sh /root/

RUN apk add --no-cache wget bash unzip tini gcompat libstdc++ && \
    bash ./download.sh ${TARGETPLATFORM} ${GLIBC_VERSION} ${SNELL_SERVER_VERSION} && \
    apk add --no-cache --allow-untrusted --force-overwrite glibc.apk glibc-bin.apk && \
    mv snell-server /usr/bin/ && \
    rm *.apk && \
    apk del wget bash unzip

ENV PORT=6250 \
    IPV6=false \
    DNS=1.0.0.1 \
    PSK=

ENTRYPOINT ["/sbin/tini","--","/root/entrypoint.sh"]
