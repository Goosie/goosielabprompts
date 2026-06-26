---
name: project_proofofread_onboarding
description: "ProofOfRead beginner front door (/start) — no-Nostr onboarding, three-tier 21-sat reward, custodial earmarks + clawback"
metadata: 
  node_type: memory
  type: project
  originSessionId: fb1ad775-ad8b-423c-88f1-333a03e68ccf
---

Built 2026-06-26: a plain-URL front door at **https://goosielabs.com/apps/proofofread/start** that onboards people with zero Nostr/Bitcoin knowledge. Flow: landing → read The Honk Standard → 5-question MC quiz (pass 4/5) → badge + 21 sats. Branch `assistenty/beginner-onboard-2026-06-26` (proofofread app repo).

**Why it exists:** the old onboarding was a Nostr DM (Welcome goose) → assumed the user already had Nostr; redeem needed them to paste a Lightning address; badge went to a throwaway key. `/start` fixes all three.

**Three-tier reward** (`api/src/routes/onboard.ts`, hardcoded tunables): beginner (no extension) → fresh 12-word NIP-06 identity in localStorage + **custodial earmark** (sats held in pool, 7-day deadline to self-withdraw or clawback). Experienced (extension + lud16) → **auto-pay** straight to their Lightning address. earmarks table keyed by pubkey (PK = idempotency / no double-pay; /reward reserves-first then pays). Program cap `MAX_PROGRAM_SATS=2100` (~100 rewards) then pauses gracefully.

**Reward pool wallet:** dedicated LNbits `proofofread-onboarding` (id 66402d0b…). Fund it via Lightning address **onboarding@goosielabs.com** (registered in scripts/lnaddress via `people/onboarding/lnbits-wallet.json`). Keys in app `api/.env` (`ONBOARD_LNBITS_ADMINKEY/INKEY`, gitignored). Finny's funding rec: 2500 sats (2100 cap + ~400 fee buffer). Verified live: real 21-sat withdrawal to finny@ works.

**Clawback:** `scripts/onboarding-clawback/index.mjs` → secret-guarded `POST /api/onboard/clawback` flips expired custodial earmarks reserved→expired. Scheduled in [[feedback_blocky_time_source|Blocky]] DEFAULT_SCHEDULE (~144 blocks), dispatched by goose-runner (signs as Welcome). Never cron.

**Open follow-ups (Finny/Secury flagged, not yet done):** (1) generalise `finny wallet-check` to monitor the onboarding wallet (~210 sat threshold) + add to Blocky ~18 blocks; (2) Secury per-IP rate-limit before raising the cap (free keygen = sybil farming, bounded only by cap). TestPage quiz UI is still Dutch while the beginner flow is English (pre-existing inconsistency, untouched).

Welcome DM (nostr-listener) now offers /start as a "share with a no-Nostr friend" link, NOT a replacement for the voucher flow (its recipients already have Nostr).
