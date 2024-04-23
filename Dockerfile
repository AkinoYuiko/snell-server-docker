FROM --platform=${BUILDPLATFORM} alpine AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG SNELL_SERVER_VERSION="4.0.1"

RUN apk add wget unzip bash

WORKDIR /app/

COPY download.sh .
RUN bash ./download.sh ${TARGETPLATFORM}

FROM --platform=${TARGETPLATFORM} alpine AS exec

WORKDIR /app/

COPY --from=builder /app/snell-server .
COPY *.apk .
COPY entrypoint.sh .

RUN apk add --no-cache gcompat libstdc++ &&\
    rm /lib/ld-linux-x86-64.so.2 &&\
    apk add --no-cache --allow-untrusted --force-overwrite glibc-2.39-r1.apk glibc-bin-2.39-r1.apk &&\
    rm *.apk &&\
    chmod +x snell-server &&\
    chmod +x entrypoint.sh

ENV LANG=C.UTF-8
ENV TZ=Asia/Hongkong
ENV PORT=6250
ENV IPV6=false
ENV PSK=

LABEL version="${SNELL_SERVER_VERSION}"

ENTRYPOINT ["/app/entrypoint.sh"]
