#!/usr/bin/env bash
set -e

echo "🚀 Tempo RPC Node – One Click Setup"

# --- SUDO CHECK ---
if [ "$EUID" -ne 0 ]; then
  echo "🔐 Re-running with sudo..."
  exec sudo bash "$0"
fi

# --- BASIC DEPS ---
echo "📦 Installing dependencies..."
apt update -y
apt install -y curl wget git lz4 tar

# --- INSTALL TEMPO ---
if ! command -v tempo >/dev/null 2>&1; then
  echo "⬇️ Installing Tempo binary..."
  curl -L https://github.com/tempoxyz/tempo/releases/latest/download/tempo-linux-amd64 -o /usr/local/bin/tempo
  chmod +x /usr/local/bin/tempo
fi

# --- CLEAN OLD DATA ---
echo "🧹 Cleaning old data..."
pkill tempo || true
rm -rf /root/.local/share/reth/tempo-testnet
rm -rf /root/.cache/reth

# --- SNAPSHOT ---
echo "📥 Downloading snapshot..."
tempo download

# --- RUN NODE ---
echo "▶️ Starting Tempo RPC Node..."
exec tempo node \
  --follow \
  --http \
  --http.addr 0.0.0.0 \
  --http.port 8545 \
  --http.api eth,net,web3,txpool,trace
