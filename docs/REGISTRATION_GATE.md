# Registration gate — read before `anchor test`

Turbin3 verifies that **your** vault program's `withdraw` instruction CPIs into the registration program. Registration is **one wallet, one time**.

## Current environment (verified)

| Item | Value |
|------|--------|
| WSL default wallet | `28M4TxRGsh5fbo7BDfR7gtdAxbsPjmMJiX8LAU32doHt` |
| WSL Solana CLI RPC | **devnet** (`https://api.devnet.solana.com`) |
| Devnet balance | ~2.23 SOL (last check) |
| Mainnet balance | 0 SOL — do not use for Turbin3 |
| Registration PDA | `6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5` — **not created yet** |
| Vault program on devnet | **Not deployed** at `DrkFYtt…` yet |
| Vault program id (keypair) | `DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP` |
| Registration program (devnet) | `TRBZyQHB3m68FGeVsqTK39Wm4xejadjVhP5MAZaKWDM` |
| `GITHUB_USERNAME` in code | `worldlabsprotocol-ux` |

## What withdraw will do on devnet

1. `initialize` — create vault state + vault PDA (no registration)
2. `deposit` — transfer SOL user → vault
3. **`withdraw`** — transfer SOL vault → user, then CPI `registration::initialize(github)` → creates `prereqs` PDA for wallet
4. `close` — drain vault, close state

Only step 3 consumes cohort registration for that wallet.

## Approve before running full test suite

Reply in chat with approval after you confirm:

1. GitHub username to bake into `constants.rs`
2. Which wallet pubkey to use (dedicated Turbin3 wallet recommended)
3. That wallet is on **devnet** and funded
4. You accept one-time registration for that wallet

## Commands (after approval — phased)

See [`DEPLOY_PLAN.md`](DEPLOY_PLAN.md) for funding math. **Recommended:** `solana airdrop 2` until balance ≥ **3 SOL** (2.23 SOL is only marginal).

```bash
# Phase 1: deploy only
anchor build && anchor deploy

# Phase 2: gate
solana program show DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP

# Phase 3: tests once (no redeploy)
anchor test --skip-deploy --skip-build
```

**Do not** run plain `anchor test` (it redeploys). **Do not** re-run Phase 3 after successful registration on this wallet.

Expected instruction list in withdraw tx: vault program withdraw + inner registration initialize + system program transfers/account creation.
