#!/bin/bash

case "$1" in
  "linux/amd64")
    wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v$3-linux-amd64.zip"
    wget --no-check-certificate -O glibc.apk "https://repo.tlle.eu.org/alpine/v3.20/main/x86_64/glibc-$2.apk"
    wget --no-check-certificate -O glibc-bin.apk "https://repo.tlle.eu.org/alpine/v3.20/main/x86_64/glibc-bin-$2.apk" ;;
  "linux/arm64")
    wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v$3-linux-aarch64.zip"
    wget --no-check-certificate -O glibc.apk "https://repo.tlle.eu.org/alpine/v3.20/main/aarch64/glibc-$2.apk"
    wget --no-check-certificate -O glibc-bin.apk "https://repo.tlle.eu.org/alpine/v3.20/main/aarch64/glibc-bin-$2.apk" ;;
  *) echo "unsupported platform: $1"; exit 1 ;;
  esac

  unzip snell.zip
  rm snell.zip
