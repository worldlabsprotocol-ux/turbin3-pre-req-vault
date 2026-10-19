#!/usr/bin/env bash
# Read-only / compile checks — no transactions
set -eu
source "${HOME}/.cargo/env"
avm use 1.1.2 >/dev/null
NODE_BIN="${HOME}/.nvm/versions/node/v24.21.0/bin"
SOLANA_BIN="${HOME}/.local/share/solana/install/active_release/bin"
export PATH="${NODE_BIN}:${SOLANA_BIN}:${HOME}/.cargo/bin:/usr/local/bin:/usr/bin:/bin"
cd "$(dirname "$0")/.."
echo "=== Solana (read-only) ==="
solana config get
solana address
solana balance
solana program show DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP | head -8
echo "=== Registration PDA (expect not found) ==="
REG_PDA="6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5"
solana account "${REG_PDA}" 2>&1 || true
echo "=== Local IDL address ==="
node -p "require('./target/idl/pre_req_vault.json').address"
echo "=== TypeScript compile ==="
npx tsc --noEmit
echo "=== Anchor.toml cluster ==="
grep -E 'cluster|pre_req_vault' Anchor.toml
