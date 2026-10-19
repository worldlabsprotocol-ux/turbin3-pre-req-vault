# Video walkthrough script (≤3 minutes)

**On screen:** `docs/architecture-diagram.png` — pan left to right with the four numbered columns.

**References (public only):** vault `DrkFYttwjh819w1t5jfKvv4AwE3aasNuikpGmsMjGbPP` · registration `TRBZyQHB3m68FGeVsqTK39Wm4xejadjVhP5MAZaKWDM` · GitHub `worldlabsprotocol-ux` · withdraw tx `438pmVMP…1gyTby` (devnet).

---

## Color legend (point once at top of diagram)

| Color | Meaning |
|-------|---------|
| Green | User wallet — signer on every instruction |
| Blue boxes | Vault program (top) and System Program |
| Purple | Registration program |
| Orange cylinders | PDAs (on-chain accounts) |
| White boxes in columns | Instructions / withdraw sub-steps |

---

### [0:00–0:15] Intro

*(Pan the **four columns** ① → ④ left to right.)*

This diagram is my Turbin3 devnet vault: four instructions in order — initialize, deposit, withdraw, close — with a registration CPI only on withdraw.

---

### [0:15–0:40] ① Initialize

*(Column **①**; point **VaultState** and **Vault** PDAs below.)*

I sign and pay rent. The program creates **VaultState** with seeds `state` plus my pubkey and stores the bumps. The **Vault** PDA is derived with `vault` plus vault state — it holds SOL but no custom data.

---

### [0:40–1:00] ② Deposit

*(Column **②**; trace **deposit** → **System Program** → **Vault PDA**.)*

I sign again. **Deposit** moves lamports from my wallet into the vault PDA through the System Program. Only I sign.

---

### [1:00–1:50] ③ Withdraw — A then B

*(Column **③**; highlight **A** then **B**.)*

**Withdraw** is two steps.

**Step A:** The vault PDA signs an outbound transfer — `invoke_signed` — SOL back to me via the System Program.

**Step B:** My vault program CPIs into Turbin3’s registration program and calls **`initialize`** with GitHub **`worldlabsprotocol-ux`**. That creates the **Prereqs PDA**. I’m still the signer on the outer transaction, so verification sees registration through **my vault’s withdraw**, not a direct client call.

*(Optional: show devnet explorer for tx `438pmVMP…`.)*

---

### [1:50–2:15] ④ Close

*(Column **④**.)*

**Close:** The vault PDA signs draining any remaining lamports to me, then **VaultState** closes and rent returns to my wallet.

---

### [2:15–2:50] Verification

*(Point at **Prereqs PDA** and column ③ again.)*

I deployed program `DrkFYtt…` once and ran devnet tests once — four passing. Registration is on-chain for `worldlabsprotocol-ux`. I will not re-run withdraw on this wallet.

---

### [2:50–3:00] Outro

That’s the left-to-right flow: PDAs for custody, System Program for SOL, registration CPI only on withdraw. Thanks.

---

## Record & upload

1. Display **`architecture-diagram.png`**; zoom so column ③ A/B text is readable.  
2. Move **left → right** through ①–④.  
3. Record ≤3 min · YouTube (accessible) · **Captions on**.  
4. Submit at [prereq.turbin3.org](https://prereq.turbin3.org/) with repo URL + diagram + video + Part 2 Doc.
