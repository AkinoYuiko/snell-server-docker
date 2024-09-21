#!/bin/sh

set -e

BIN="snell-server"
CONF="/root/snell-server.conf"

run() {
  if [ ! -f ${CONF} ]; then
    PSK=${PSK:-$(tr -dc A-Za-z0-9 </dev/urandom | head -c 31)}
    PORT=${PORT:-6250}
    IPV6=${IPV6:-false}
    DNS=${DNS:-1.0.0.1}

    echo "Using DNS: ${DNS}"
    echo "Using PSK: ${PSK}"
    echo "Using port: ${PORT}"
    echo "Using ipv6: ${IPV6}"

    echo "Generating new config..."
    cat << EOF > ${CONF}
[snell-server]
listen = :::${PORT}
psk = ${PSK}
dns = ${DNS}
ipv6 = ${IPV6}
EOF
  fi
  echo -e "Starting snell-server...\n"
  echo "Config:"
  cat ${CONF}
  ${BIN} -c ${CONF}
}

run
