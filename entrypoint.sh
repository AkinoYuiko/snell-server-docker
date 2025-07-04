#!/bin/bash
set -e

random_port() {
  shuf -i 1024-65535 -n 1
}

random_psk() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1
}

generate_config() {

  PORT=${PORT:-$(random_port)}
  PSK=${PSK:-$(random_psk)}
  IPV6=${IPV6:-false}

  cat >/snell/snell.conf <<EOF
[snell-server]
listen=:::$PORT
psk=$PSK
ipv6=$IPV6
EOF

  declare -A config_map=([DNS]="dns" [OBFS]="obfs" [HOST]="obfs-host")

  for key in "${!config_map[@]}"; do
    if [ -n "${!key}" ]; then
      echo "${config_map[$key]}=${!key}" >>/snell/snell.conf
    fi
  done
}

download_snell() {
  VERSION=${VERSION:-v4.1.1}
  case "${TARGETPLATFORM}" in
    "linux/amd64") SNELL_URL="https://dl.nssurge.com/snell/snell-server-${VERSION}-linux-amd64.zip" ;;
    "linux/386") SNELL_URL="https://dl.nssurge.com/snell/snell-server-${VERSION}-linux-i386.zip" ;;
    "linux/arm64") SNELL_URL="https://dl.nssurge.com/snell/snell-server-${VERSION}-linux-aarch64.zip" ;;
    "linux/arm/v7") SNELL_URL="https://dl.nssurge.com/snell/snell-server-${VERSION}-linux-armv7l.zip" ;;
    *) echo "不支持的平台: ${TARGETPLATFORM}" && exit 1 ;;
    esac

  wget -q -O snell.zip ${SNELL_URL} &&
    unzip -qo snell.zip -d /snell &&
    rm snell.zip &&
    chmod +x /snell/snell-server
}

download_snell
generate_config
echo "PORT:$PORT"
echo "PSK:$PSK"
echo "VERSION:$VERSION"
[ -n "$DNS" ] && echo "DNS:$DNS"
[ -n "$OBFS" ] && echo "OBFS:$OBFS"
[ -n "$HOST" ] && echo "HOST:$HOST"
exec /snell/snell-server -c /snell/snell.conf -l ${LOG:-notify}
