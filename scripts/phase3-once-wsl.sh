#!/usr/bin/env bash
# Phase 3 — run ONCE after explicit approval. Performs one-time registration on withdraw.
set -eu
source "${HOME}/.cargo/env"
avm use 1.1.2 >/dev/null
NODE_BIN="${HOME}/.nvm/versions/node/v24.21.0/bin"
SOLANA_BIN="${HOME}/.local/share/solana/install/active_release/bin"
export PATH="${NODE_BIN}:${SOLANA_BIN}:${HOME}/.cargo/bin:/usr/local/bin:/usr/bin:/bin"
cd "$(dirname "$0")/.."
solana config get
solana balance
anchor test --skip-deploy --skip-build
