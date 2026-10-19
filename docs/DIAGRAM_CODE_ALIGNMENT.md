# Diagram ↔ code verification

Checked against `programs/pre-req-vault/src/instructions/*.rs` on 2026-10-19.

| Diagram element | Code reference | Match |
|-----------------|----------------|-------|
| VaultState seeds `state + user` | `initialize.rs` `seeds = [b"state", user.key()]` | Yes |
| Vault seeds `vault + vault_state` | `initialize.rs` / all ix | Yes |
| VaultState fields `vault_bump`, `state_bump` | `state.rs`, set in `initialize` | Yes |
| Initialize: user signer + payer | `user: Signer`, `payer = user` on init | Yes |
| Deposit: user → vault System transfer | `deposit.rs` `from: user`, `to: vault` | Yes |
| Deposit: user only signer | No PDA seeds on deposit CPI | Yes |
| Withdraw Step A: vault → user, PDA sign | `withdraw.rs` `new_with_signer` + vault seeds | Yes |
| Withdraw Step B: registration CPI | `initialize(reg_ctx, GITHUB_USERNAME)` | Yes |
| Prereqs PDA seeds | `withdraw.rs` `seeds = [b"prereqs", user]` + `seeds::program = application_program` | Yes |
| Registration program id | `Program<registration::…>` + IDL `TRBZyQHB…` | Yes |
| Close: drain vault lamports, PDA sign | `close.rs` `transfer(..., self.vault.lamports())` | Yes |
| Close: `vault_state` closed to user | `close = user` on vault_state | Yes |
| CPI order on withdraw | Transfer first, then `initialize` CPI | Yes |

Program ids on diagram use shortened labels; full ids in README and `architecture.md`.

**Layout (2026-10-19):** Top legend + user → four columns ①–④ (LR) → PDA row → System / Registration anchors. Withdraw column chains **A (vault PDA signed transfer)** then **B (registration CPI)** matching `withdraw.rs` instruction order.
