FROM alpine

ARG TARGETPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1

RUN apk add --no-cache wget unzip  && \
    echo 'https://storage.sev.monster/alpine/edge/testing' | tee -a /etc/apk/repositories && \
    wget https://storage.sev.monster/alpine/edge/testing/x86_64/sevmonster-keys-1-r0.apk && \
    apk add --allow-untrusted ./sevmonster-keys-1-r0.apk && \
    apk update && \
    apk add --no-cache gcompat libstdc++ && \
    rm /lib/ld-linux-x86-64.so.2 && \
    apk add --no-cache --force-overwrite glibc && \
    apk add --no-cache glibc-bin && \
    rm ./sevmonster-keys-1-r0.apk

WORKDIR /app/

RUN case "${TARGETPLATFORM}" in \
    "linux/amd64") wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-amd64.zip" ;; \
    "linux/arm64") wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-aarch64.zip" ;; \
    "linux/arm/v7") wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-armv7l.zip" ;; \
    "linux/386") wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-i386.zip" ;; \
    *) echo "unsupported platform: ${TARGETPLATFORM}"; exit 1 ;; \
    esac

COPY entrypoint.sh /app/

RUN if [ -f snell.zip ]; then unzip snell.zip && rm -f snell.zip; fi && \
    chmod +x snell-server && \
    chmod +x entrypoint.sh

ENV LANG=C.UTF-8
ENV TZ=Asia/Hongkong
ENV PORT=6250
ENV IPV6=false
ENV PSK=

LABEL version="${SNELL_SERVER_VERSION}"

ENTRYPOINT ["/app/entrypoint.sh"]
