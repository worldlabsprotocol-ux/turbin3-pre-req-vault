# ~3 minute video script — Turbin3 Vault (recorded by you)

**Requirements:** ≤3 minutes, YouTube, **public**, **captions** enabled.  
**Use with:** [`architecture.md`](architecture.md) diagram on screen.

---

### [0:00–0:15] Introduction

Hi — this is my Turbin3 Q4 vault prerequisite walkthrough. I deployed an Anchor vault on **Solana devnet** at program id **`DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP`**. The cohort extension is a **cross-program invocation** on **withdraw** that registers my GitHub handle with Turbin3’s registration program.

---

### [0:15–0:50] Diagram — user and PDAs

*(Point to user wallet on diagram.)*

The **user wallet** signs every instruction.

Two PDAs belong to **my vault program**:

1. **Vault state** — seeds `"state"` plus my public key. It stores the bumps used to validate PDAs.
2. **Vault** — seeds `"vault"` plus the vault state address. It holds SOL; the program signs outbound transfers with the stored vault bump.

---

### [0:50–1:25] Initialize, deposit, close

**Initialize** — I pay rent to create vault state and record bumps.

**Deposit** — I sign a system transfer from my wallet into the vault PDA. Only I sign; incoming transfers don’t need the vault PDA to sign.

**Close** — The vault PDA signs a transfer that drains remaining lamports to me, then vault state closes and rent returns.

*(Optional: mention test txs `5cQad…` init, `5h5KX…` deposit, `2itXi…` close on devnet explorer.)*

---

### [1:25–2:20] Withdraw and registration CPI

**Withdraw** runs in two steps:

1. **SOL out** — The vault PDA signs a system transfer from the vault back to me (`invoke_signed` with vault seeds).
2. **Registration CPI** — My program calls Turbin3’s registration program on devnet (`TRBZyQHB…`). It passes the **prereqs** PDA for my wallet and invokes **`initialize`** with GitHub username **`worldlabsprotocol-ux`**.

That CPI must come from **my deployed vault’s withdraw instruction**, not a direct client call to registration — that’s what cohort verification checks.

*(Show explorer withdraw tx: `438pmVMP…` — inner instruction to registration program.)*

Registration account: **`6cAp3qGX91HWE1LMyfmFP9KAU8J2eFCX6N9Cdp98dWv5`**.

---

### [2:20–2:50] What we verified

I ran TypeScript integration tests **once** on devnet with **`anchor test --skip-deploy --skip-build`** after deploying my program. **All four tests passed.** Registration happened only on the withdraw step; I will **not** re-run those tests on the same wallet because registration is one-time per wallet.

---

### [2:50–3:00] Closing

That’s the design: per-user PDAs for custody, system program for SOL movement, and a registration CPI on withdraw. Thanks.

---

## Recording checklist

- [ ] Diagram visible (exported PNG from Mermaid)  
- [ ] Speak clearly; phone is fine per cohort  
- [ ] Upload to YouTube (unlisted or public — cohort must access)  
- [ ] Enable captions (auto + quick review)  
- [ ] Paste link into portal with GitHub repo and diagram  
