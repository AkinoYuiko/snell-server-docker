FROM --platform=${BUILDPLATFORM} alpine AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1


RUN apk add wget unzip bash

WORKDIR /app/

COPY download.sh .
RUN bash ./download.sh ${TARGETPLATFORM} ${SNELL_SERVER_VERSION}

FROM --platform=${TARGETPLATFORM} debian:stable-slim AS exec

ARG TARGETPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1

WORKDIR /app/

COPY --from=builder /app/snell-server .
COPY entrypoint.sh .

RUN chmod +x snell-server &&\
    chmod +x entrypoint.sh

ENV LANG=C.UTF-8
ENV TZ=Asia/Hongkong
ENV PORT=6250
ENV IPV6=false
ENV PSK=

LABEL version="${SNELL_SERVER_VERSION}"

ENTRYPOINT ["/app/entrypoint.sh"]
