# Turbin3 Q4 2026 — Vault prerequisite (Part 1)

Modified Anchor vault for the [Turbin3 Builders Cohort prerequisites](https://prereq.turbin3.org/): **withdraw** performs a CPI to the cohort **registration** program and records a GitHub username.

Solana vault prerequisite codebase only (not Abraxas product code).

## Deployed program (Solana devnet)

| | |
|--|--|
| **Network** | Solana **devnet** |
| **Vault program** | [`DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP`](https://explorer.solana.com/address/DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP?cluster=devnet) |
| **Registration program** | `TRBZyQHB3m68FGeVsqTK39Wm4xejadjVhP5MAZaKWDM` |
| **GitHub username (on-chain)** | `worldlabsprotocol-ux` |
| **Registration PDA** | [`6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5`](https://explorer.solana.com/address/6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5?cluster=devnet) |

Program deploy slot: **512917871** (ProgramData `GfiAXAwtwLk8AdKzU1TqpBPTPufGmusrCLwbXBxAj6B4`).

## Devnet test results (Phase 3 — single run)

Command: `anchor test --skip-deploy --skip-build` (after deploy; **do not re-run** on the registration wallet).

| Test | Result | Signature |
|------|--------|-------------|
| Initialize vault | Pass | [`5cQadHMX…`](https://explorer.solana.com/tx/5cQadHMX6WuYnhCjeD6tc9H8r9j1byKKJLCQ2oekcx9Wy5ZrozbugPAiaebyJuPrXuDPr4Aq97wDiutp9PhGRRVS?cluster=devnet) |
| Deposit 1 SOL | Pass | [`5h5KX85…`](https://explorer.solana.com/tx/5h5KX85ELP3EMAETPXN8dBGtseiHNviDqzpdjdcjQg1orfFwk9bUiKL2Xk7yZizJubKtMZjzwxa9SRb32Mr8GaRD?cluster=devnet) |
| Withdraw 0.5 SOL + **registration CPI** | Pass | [`438pmVMP…`](https://explorer.solana.com/tx/438pmVMPVd9vL1cLP7HpXheGFveNiSLndCMSpNHvD8mwikKif8HBYzNK1bEeAtppcSSM6pBWRBEQ6XDgMz1gyTby?cluster=devnet) |
| Close vault | Pass | [`2itXiEQ…`](https://explorer.solana.com/tx/2itXiEQstCmaGa7G3viDkuu4zXeoqtRhTJDP8bZ5NYdreZRidRyLWmAnxC7ukbYzBhq7C6aGzN7rUVowL3Y12zRA?cluster=devnet) |

**4 / 4 passing** (devnet, confirmed).

## Cohort extension

In `programs/pre-req-vault/src/instructions/withdraw.rs`, after the vault-to-user SOL transfer, the program CPIs `registration::initialize` with `GITHUB_USERNAME` from `constants.rs` (`worldlabsprotocol-ux`).

## Architecture & video

- Architecture diagram (PNG): [`docs/architecture-diagram.png`](docs/architecture-diagram.png)  
- Video walkthrough: [Watch the Turbin3 vault demo](https://youtu.be/Q9T4i_pILys)  
- Diagram (Mermaid + export instructions): [`docs/architecture.md`](docs/architecture.md)  
- Raw Mermaid source: [`docs/architecture-diagram.mmd`](docs/architecture-diagram.mmd)  
- Video script: [`docs/VIDEO_SCRIPT.md`](docs/VIDEO_SCRIPT.md)  

## Local development

- **Toolchain:** WSL Ubuntu — Rust, Solana CLI, Anchor **1.1.2** (`avm`)  
- **Tests:** `cluster = "devnet"`, `skip_local_validator = true` in `Anchor.toml`  
- **WSL + `/mnt/c` projects:** use Linux Node for Anchor npm steps — see [`docs/IDL_FIX.md`](docs/IDL_FIX.md)  

```bash
npm install
anchor build
# Deploy once, then test once with skip flags — see docs/DEPLOY_PLAN.md
```

Never commit keypairs (`target/deploy/*-keypair.json`, `id.json`).

## Capstone pre-work (Part 2 — supplementary)

Turbin3 Part 2 is **founder-authored** capstone pre-work. The portal checklist may not expose a separate upload field; this repo includes supplementary material for reviewers:

- **[`docs/ABRAXAS_CAPSTONE.md`](docs/ABRAXAS_CAPSTONE.md)** — Abraxas capstone pre-work (RWA category; founder-authored concept, PMF, and founder–market fit)  
- Policy reminder: [`docs/PART2_CAPSTONE.md`](docs/PART2_CAPSTONE.md)  

Publishing here does **not** replace any official Turbin3 submission step. Capstone sections are founder-authored in [`docs/ABRAXAS_CAPSTONE.md`](docs/ABRAXAS_CAPSTONE.md).

## Submission

Full checklist and portal fields: [`docs/SUBMISSION.md`](docs/SUBMISSION.md)  

**Deadline:** Wed **21 Oct 2026, 15:00 UTC** — Part 1: repo + diagram + video; Part 2: your capstone (Doc or supplementary markdown as cohort directs).

## Reference

Starter: [ShrinathNR/pre-req-vault](https://github.com/ShrinathNR/pre-req-vault) (`git remote` name: **`upstream`**).
