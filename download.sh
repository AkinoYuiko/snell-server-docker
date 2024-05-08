#!/bin/bash

case "$1" in
  "linux/amd64")
    wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip"
    wget --no-check-certificate -O tini "https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64" ;;
  "linux/arm64")
    wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-aarch64.zip"
    wget --no-check-certificate -O tini "https://github.com/krallin/tini/releases/download/v0.19.0/tini-arm64" ;;
  *) echo "unsupported platform: $1"; exit 1 ;; 
  esac

  unzip snell.zip
  rm snell.zip
