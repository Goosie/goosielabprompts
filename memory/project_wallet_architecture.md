---
name: project-wallet-architecture
description: "How the LNbits wallets + flock sat-distribution are wired (Splitty = hub, Perry = personal) after the 2026-06-29 restructure"
metadata: 
  node_type: memory
  type: project
  originSessionId: d4a856fb-f003-44ab-b4ec-61649a01b9a9
---

Goosie Labs LNbits wallet / sat-distribution layout (set up 2026-06-29):

- **Splitty** (goose, wallet name "Splitty" `f6f82f43…`, `splitty@goosielabs.com`, npub1eyln9xk…) is the **flock treasurer / distribution hub**. Its wallet is the splitpayments **source**: every incoming sat is auto-split evenly (~3.33% each) across all geese + Perry's personal wallet, keeping nothing. Send/zap shared income here → whole flock gets fed at once.
- **Perry** (LNbits wallet "Perry" `c9ac4e7c…`) is Perry's **personal** wallet, used in Amethyst over NWC (relay nos.lol). It is NO LONGER a splitpayments source (was the hub before — incoming used to leak away to the flock). It IS one of Splitty's split targets.
- **amethyst-phone-perry** `0e670397` was a short-lived detour wallet — now retired (`deleted=1`, renamed "Amethyst-RETIRED"), its NWC connection + `amethyst@` address removed.

New geese are auto-added to Splitty's split: `humany`'s `updateSplitTargets()` (in `scripts/humany/index.mjs`) now uses Splitty's wallet as source + all geese + Perry as targets, and runs on every `newgoose`.

⚠️ humany bug fixed same day: `newGoose()` did `return` when the (removed) vformation `gooseConfig.ts` was missing, silently aborting wallet/profile/badge/ceremony/tile. Now it skips-and-continues; step-7 vformation rebuild is guarded too.

Fixed 2026-06-29: `publish-agent-pages.mjs` used to hardcode `import(...apps/catchzaps/node_modules/nostr-tools/lib/esm/index.js)` and broke when that app changed. Now imports the bare `nostr-tools` specifier from its own stable install in `/home/deploy/systemsetup/node_modules` (added a minimal `systemsetup/package.json`). Note: `sync-agents` is a shell alias, not in PATH for scripts — edit `agents.json` directly if needed. See [[reference-lnbits-nwc-setup]].
