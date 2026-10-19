# IDL initialization failure — root cause & fix

## What failed during `anchor deploy`

After the program binary uploaded successfully, Anchor ran **on-chain IDL initialization** via an **npm/Node subprocess**. That subprocess failed with:

```text
[Warning] Solana config file not found
[Error] Keypair file not found at: /home/worldlabspro/.config/solana/id.json
Error: Failed to initialize IDL
```

## Root cause

1. The repo lives on **`/mnt/c/...`** (Windows drive mounted in WSL).
2. Default WSL `PATH` prioritizes **Windows Node/npm** (`/mnt/c/Program Files/nodejs/npm`).
3. Anchor’s IDL init step runs **Node tooling** that expects a Solana config/keypair resolvable from **that** environment.
4. Windows Node **cannot read** WSL-only paths such as `/home/worldlabspro/.config/solana/id.json`, even when Anchor passes that path — hence “Keypair file not found”.
5. The **program deploy itself** uses the Rust/Solana CLI path and **succeeded**; only the **IDL metadata upload** failed.

## Fix (no redeploy required)

Use **Linux Node** from nvm when running Anchor npm steps:

```bash
export PATH="$HOME/.nvm/versions/node/v24.21.0/bin:$HOME/.cargo/bin:/usr/bin:/bin"
```

Then:

```bash
anchor idl init \
  --filepath target/idl/pre_req_vault.json \
  DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP \
  --provider.wallet "$HOME/.config/solana/id.json"
```

Or run: `bash scripts/idl-init-wsl.sh` (already executed successfully post-deploy).

**On-chain IDL metadata:** `51E2AEmKoc8h39WNVZi6e3ag4z97f6vTGc6GCeYt4XHr` (seed `idl`, program `DrkFYtt…`).

## Phase 3 tests

TypeScript integration tests use **local** artifacts from `anchor build`:

- `target/idl/pre_req_vault.json`
- `target/types/pre_req_vault.ts`

On-chain IDL is optional for `anchor test --skip-deploy` but is now initialized for explorers/clients.

Always use the **Linux Node PATH** above (or `scripts/phase3-once-wsl.sh`) so npm steps do not regress to Windows Node.
