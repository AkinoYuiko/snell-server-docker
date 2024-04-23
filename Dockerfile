FROM --platform=${BUILDPLATFORM} debian AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1

RUN apt-get update &&\
    apt-get install -y --no-install-recommends wget unzip &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY download.sh .
RUN echo "nameserver 1.1.1.1" > /etc/resolv.conf &&\
    bash ./download.sh ${TARGETPLATFORM} ${SNELL_SERVER_VERSION}

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
