# Pre-publication security audit

**Date:** 2026-10-19  
**Action:** Push **blocked** until you approve publication.

## Git remotes

| Remote | URL | OK? |
|--------|-----|-----|
| `upstream` | `https://github.com/ShrinathNR/pre-req-vault.git` | Yes — reference only |
| `origin` | *(not configured yet)* | Add after creating GitHub repo |

**Planned `origin`:** `https://github.com/worldlabsprotocol-ux/turbin3-pre-req-vault.git`

## Secrets scan (repository tree)

| Check | Result |
|-------|--------|
| `id.json` / `*-keypair.json` in tracked files | **None** |
| Byte array private keys in source | **None** |
| Seed phrases | **None** |
| `.env` files | **None** |
| `target/` committed | **No** — in `.gitignore` |
| `node_modules/` committed | **No** — in `.gitignore` |
| Abraxas references in code | **None** (README disclaimer only) |

## Paths that must never be committed

- `target/deploy/pre_req_vault-keypair.json` (program deploy authority)  
- `target/deploy/*-upgrade-buffer.json`  
- `~/.config/solana/id.json` (wallet)  
- Any `.env` with RPC or keys  

## Docs mentioning wallet path

Internal docs reference `~/.config/solana/id.json` as **path examples only** — no key material. Public README uses **public keys** and explorer links only.

## Files to include in first commit

Source, tests, IDL reference, docs, scripts, `package.json`, `package-lock.json`, lockfiles — **not** `target/`, `node_modules/`, `.anchor/`.

## After you approve publication

```bash
# Create empty public repo on GitHub: worldlabsprotocol-ux/turbin3-pre-req-vault
git remote add origin https://github.com/worldlabsprotocol-ux/turbin3-pre-req-vault.git
git add -A
git status   # verify no target/, node_modules/, *keypair*
git commit -m "Turbin3 Q4 vault: withdraw registration CPI and devnet verification"
git push -u origin main
```
