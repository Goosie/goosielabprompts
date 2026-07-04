---
name: start-here-depth-pivot
description: "Start Here onboarding pivoted to \"depth\" — user installs a real Nostr client, makes their own key, posts"
metadata: 
  node_type: memory
  type: project
  originSessionId: d4a856fb-f003-44ab-b4ec-61649a01b9a9
---

On 2026-07-02 Perry pivoted the "Start here" onboarding (start.goosielabs.com → /apps/proofofread/start) away from the custodial-feeling "we create your account + give you sats + quiz you" flow. Chosen direction: **depth over reach**.

**New flow — three felt beats, not three crammed things:** (1) the user installs a real Nostr client and makes their OWN key by instruction (screenshots); (2) the user posts `HONK #goosielabs` publicly; (3) the Welcome goose — which already listens for #goosielabs and already sends a 21-sat Cashu welcome token — hears them across relays and honks back WITH the sats, so the sats arrive as a social zap-reply, not a quiz reward. The Start Here page should live-listen and light up when it hears them.

**Why:** the old flow did three jobs (Nostr identity + sats + proof-of-read) in one run — too much, custodial-feeling, and the quiz was homework you can't hand someone you're trying to convert. The depth flow makes the user genuinely FEEL ownership (own key, own client, un-takeable post), it finally MATCHES the manifesto's "you only understand decentralization by trying it," it's legally cleanest (we are not custodian nor identity provider), and it leaves a public artifact per user (shareable + a real app they reopen = the "comes back a second time" bar).

**Parked/changed by this pivot:**
- The NIP-60 "one key holds all three" build is PARKED — a real client owns the wallet, so no key-recovery plumbing is needed for the demo. (Verified 2026-07-02: Iris does NOT actually read NIP-60 — local-seed Cashu wallet, event kinds 17375/7375 defined but unused — so it was never a working recovery target anyway.)
- Proof-of-read / the badge returns to the ProofOfRead app as the optional *second* door, for someone who already felt ownership and wants to go deeper. See [[project_proofofread_onboarding]].

**Framing rules locked:** emotion is "nobody can take it from you" (ownership/safety), NOT "you can never delete it" (permanence/fear — and it's false: kind-5 delete requests exist, relays just don't have to obey). Say "no single company can erase it." Keep the goose tip a warm surprise, not an advertised payout (faucet + legal hygiene).

**SHIPPED 2026-07-03:** instruction page LIVE at start.goosielabs.com → /apps/start/ (plain HTML `index.html`, homepage-blue `#0C447C` palette + the goosielabs.com nav bar so users can switch back). Clients recommended: **Damus (iOS) + Amethyst (Android)**. Reply-first honk-back is LIVE + tested end-to-end: `systemsetup/scripts/humany/nostr-listener.mjs#handleGoosielabsMention` now posts a public kind:1 honk-back (no voucher, no sats) via `publishPublicReply`, one per pubkey (dedup file `logs/nostr-listener-honked.json`). Tile `icon_bg` blue `#0C447C`. Committed: goosielabs `aa7c8d0`, systemsetup `19bbc6d`+`e8d1b43`, pushed to gitea.

**Amendment B (shipped 2026-07-04):** live **Honk Stream** on the start page (`/apps/start/honk-stream.js`) — subscribes to PUBLIC relays (nos.lol/damus/primal) because our relay is kind:1 whitelist-only, so a newcomer's honk lands there, NOT on relay.goosielabs.com; text-only + guard-railed (latest 15, 200-char clamp, word filter, ignore >1000 chars), desktop right-rail / mobile under step 3, `STREAM_ENABLED` kill-switch. Also: QR codes to the app stores (`qr-damus.png`/`qr-amethyst.png`, desktop only), per-step "you'll know it worked when…" checks, homepage newcomer-card copy + first-tile labels ("Start here"/"More background") reworded, and the "own 3 things" hero CTA removed (English generation in `publish-homepage.mjs`). **NEXT-PHASE TODO** (noted in honk-stream.js): NostResponder auto-reply + nutzap 21 sats + NIP-58 badge — the day it ships, restore the homepage "own 3 things" promise (it becomes true again). Homepage `/var/www/goosielabs` is auto-git-committed daily at 03:00 by a `backup-...` job — manual commits there can race it.

**Palette note:** goosielabs.com homepage uses an inline **blue** palette (`--blue-800 #0C447C`); the shared `/template.css` (Cssy) is the **app** system, **indigo #6366f1**. Start-here is a site front door → blue. (Homepage-blue vs apps-indigo is a real design-system fork for Cssy to unify someday.)

**Stale docs to fix:** the flock roster + Welcome's `description`/`welcome.md` still say Welcome "sends a 21-sat Cashu welcome token" — no longer true (it honks back publicly). Update Welcome's description + run sync-agents.

**Remaining:** the 21-sat tip is deferred to v2 — must be a Lightning zap to `npub@npub.cash`, NEVER a Cashu nutzap (cold accounts can't receive nutzaps; verified via Gander research); faucet guards beyond one-per-npub (pool cap / rate-limit) when the tip returns; manifest Sections 4 + 7 still describe the OLD in-browser demo and need rewriting to the "make your own key → honk → get answered" flow, with the "words can't get you wet / try before you leave" refrain off the swimming metaphor.
