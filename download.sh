#!/bin/bash

case "$1" in
  "linux/amd64")
    wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v$2-linux-amd64.zip";;
  "linux/arm64")
    wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v$2-linux-aarch64.zip";;
  *) echo "unsupported platform: $1"; exit 1 ;;
  esac

  unzip snell.zip
  rm snell.zip
