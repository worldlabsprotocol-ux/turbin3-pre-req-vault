# Deploy & test execution plan (phased)

**Status:** Pre-flight complete. **No deploy or registration tx has been sent.**

## Identities

| Role | Address / value |
|------|-----------------|
| Devnet wallet (WSL `~/.config/solana/id.json`) | `28M4TxRGsh5fbo7BDfR7gtdAxbsPjmMJiX8LAU32doHt` |
| GitHub username (in program) | `worldlabsprotocol-ux` |
| Your vault program id | `DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP` |
| Registration program (devnet) | `TRBZyQHB3m68FGeVsqTK39Wm4xejadjVhP5MAZaKWDM` |
| Registration PDA (`["prereqs", wallet]`) | `6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5` |

---

## Devnet funding analysis (verified)

| Item | Estimated cost (SOL) | Notes |
|------|----------------------|--------|
| Program data rent (`176,952` byte `.so`) | **~0.8996** | `solana rent 176952` on devnet |
| Program / loader overhead | **~0.001–0.01** | Small accounts + fees |
| Vault `vault_state` account rent | **~0.0007** | `initialize` test |
| Registration PDA rent | **~0.0017** | Created on withdraw CPI |
| **Deposit test (peak lock)** | **1.0000** | 1 SOL moved user → vault (returned via withdraw + close) |
| Tx fees (deploy + 4 tests) | **~0.001** | Negligible on devnet |

**Rough minimum wallet balance needed for one successful run:**

- After deploy (net): **~0.91 SOL** spent on program (not returned unless you close the program).
- During tests you must still hold **1 SOL** for the deposit instruction → **~1.91 SOL** effective minimum.
- **Current balance:** **2.23345036 SOL** (devnet, last check).

**Verdict:** **Marginally sufficient** for a single deploy + full test run (~**0.32 SOL** headroom above ~1.91 SOL). That is **not** a comfortable buffer—devnet deploy can briefly require extra lamports during buffer upload, and airdrops can fail.

**Recommendation before Phase 1:** request **1–2 SOL** devnet airdrop (target **≥ 3 SOL** total), then re-check `solana balance`.

```bash
solana airdrop 2   # repeat once if rate-limited; devnet only
solana balance
```

---

## Phased execution (required — do not use bare `anchor test` alone)

`anchor test` without flags **builds, deploys, and runs all tests** in one step. Use **three phases** instead:

### Phase 1 — Deploy only (first on-chain operation)

```bash
source ~/.cargo/env && avm use 1.1.2
cd /mnt/c/Users/deant/OneDrive/Desktop/turbin3-prereqs

solana config get          # RPC must be devnet
solana balance             # confirm funding (see table above)

anchor build
anchor deploy
```

### Phase 2 — Confirm program on devnet (gate before tests)

```bash
solana program show DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP
# Expect: Program Id, Owner (BPF loader), Data Length, Authority = your wallet
```

**Do not proceed to Phase 3 until this succeeds.**

### Phase 3 — Tests once (registration on withdraw)

Run tests **without redeploying**. Use **Linux Node** (see [`IDL_FIX.md`](IDL_FIX.md)) — do not use bare `anchor test` from a broken PATH.

**One-time command (after explicit approval):**

```bash
bash scripts/phase3-once-wsl.sh
```

Equivalent manual command:

```bash
export PATH="$HOME/.nvm/versions/node/v24.21.0/bin:$HOME/.local/share/solana/install/active_release/bin:$HOME/.cargo/bin:/usr/bin:/bin"
source ~/.cargo/env && avm use 1.1.2
cd /mnt/c/Users/deant/OneDrive/Desktop/turbin3-prereqs
anchor test --skip-deploy --skip-build
```

**Test order (single run):**

1. `initialize` — no registration  
2. `deposit` — 1 SOL into vault  
3. **`withdraw`** — 0.5 SOL out + CPI `initialize("worldlabsprotocol-ux")` → **one-time registration**  
4. `close` — drain vault  

### After registration succeeds

- **Do not** run `anchor test` again (with or without deploy) on this wallet.
- **Do not** re-run Phase 3 on this wallet.
- Verify registration once:

```bash
solana account 6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5
```

If you need to fix code later, use a **new devnet wallet** for another registration attempt.

---

## Pre-flight checklist (done)

- [x] `GITHUB_USERNAME` = `worldlabsprotocol-ux`
- [x] Solana CLI default RPC → **devnet**
- [x] Registration PDA **not found** → not registered yet
- [x] Vault program **not deployed** yet at `DrkFYtt…`
- [x] Program id aligned across `lib.rs`, `Anchor.toml`, keypair
- [x] `anchor build` OK after username change
- [ ] **Recommended:** devnet airdrop to ≥ **3 SOL** before Phase 1

---

## GitHub publish (after on-chain success — not done yet)

Reference: `upstream` → ShrinathNR/pre-req-vault. Add your `origin`, verify no keypairs in `git status`, then push.

---

## Submission assets (ready)

- [`architecture.md`](architecture.md)
- [`VIDEO_SCRIPT.md`](VIDEO_SCRIPT.md)
