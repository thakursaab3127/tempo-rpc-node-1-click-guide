#!/bin/bash
set -e

apt update
apt install -y curl wget lz4 tar git

if ! command -v tempo &> /dev/null; then
  curl -L https://github.com/tempoxyz/tempo/releases/latest/download/tempo-linux-amd64 -o tempo
  chmod +x tempo
  mv tempo /usr/local/bin/
fi

tempo download
