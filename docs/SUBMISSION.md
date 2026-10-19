# Turbin3 Q4 2026 — Final submission guide

**Deadline:** Wednesday **21 October 2026, 15:00 UTC**  
**Portal:** [prereq.turbin3.org](https://prereq.turbin3.org/)

Submit **Part 1 (Vault)** and **Part 2 (Capstone pre-work)** together.

---

## Part 1 — Vault program (your deliverables)

| Deliverable | Status | Location / action |
|-------------|--------|-------------------|
| Public GitHub repo with CPI withdraw | Ready to publish | After audit approval → push to `worldlabsprotocol-ux/turbin3-pre-req-vault` |
| Architecture diagram | Ready | [`architecture.md`](architecture.md) → export PNG/SVG from Mermaid |
| ≤3 min YouTube video | You record | Script: [`VIDEO_SCRIPT.md`](VIDEO_SCRIPT.md) — public, captions on |

### Verified devnet evidence (include in README / optional video)

| Item | Value |
|------|--------|
| Network | **Solana devnet** |
| Vault program | [`DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP`](https://explorer.solana.com/address/DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP?cluster=devnet) |
| Registration program | `TRBZyQHB3m68FGeVsqTK39Wm4xejadjVhP5MAZaKWDM` |
| GitHub registered | `worldlabsprotocol-ux` |
| Registration PDA | [`6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5`](https://explorer.solana.com/address/6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5?cluster=devnet) |
| Registration CPI tx (withdraw test) | [`438pmVMPVd9vL1cLP7HpXheGFveNiSLndCMSpNHvD8mwikKif8HBYzNK1bEeAtppcSSM6pBWRBEQ6XDgMz1gyTby`](https://explorer.solana.com/tx/438pmVMPVd9vL1cLP7HpXheGFveNiSLndCMSpNHvD8mwikKif8HBYzNK1bEeAtppcSSM6pBWRBEQ6XDgMz1gyTby?cluster=devnet) |

---

## Part 2 — Capstone pre-work (you write)

Per portal — **draft yourself first**; AI only to stress-test after your draft.

Google Doc (~½–1 page):

1. **Category** — RWAs, Tokenization, Payments, or Collectibles  
2. **Concept overview** — 2–5 sentences  
3. **Value proposition & PMF** — one paragraph  
4. **Founder–market fit** — a few sentences  

**Do not** have Cursor generate the original idea or PMF text.

---

## Portal submission (exact fields)

The cohort site uses a **local device checklist** (not a separate public API). When you submit, you will typically provide:

1. **GitHub repository URL** — public repo with your modified vault (CPI in `withdraw`)  
2. **Architecture diagram** — file upload or link (PNG/PDF from Mermaid export)  
3. **Video URL** — YouTube, ≤3 minutes, accessible, captions enabled  
4. **Part 2 Google Doc link** — capstone pre-work  

Confirm any additional form fields on [prereq.turbin3.org](https://prereq.turbin3.org/) at submit time.

---

## Post-submission

- **Do not** re-run Phase 3 tests or redeploy on the registration wallet.  
- Keep `upstream` pointing at the reference repo; your work lives on `origin`.
