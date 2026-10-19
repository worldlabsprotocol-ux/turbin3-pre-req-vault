#!/usr/bin/env bash
set -eu
source "${HOME}/.cargo/env"
avm use 1.1.2 >/dev/null
NODE_BIN="${HOME}/.nvm/versions/node/v24.21.0/bin"
SOLANA_BIN="${HOME}/.local/share/solana/install/active_release/bin"
export PATH="${NODE_BIN}:${SOLANA_BIN}:${HOME}/.cargo/bin:/usr/local/bin:/usr/bin:/bin"
cd "$(dirname "$0")/.."
echo "node: $(command -v node) ($(node -v))"
echo "npm: $(command -v npm)"
echo "anchor: $(command -v anchor)"
anchor idl init \
  --filepath target/idl/pre_req_vault.json \
  DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP \
  --provider.wallet "${HOME}/.config/solana/id.json"
