---
name: project_nsite_migration
description: "Full decentralization roadmap — nsite (Nostr static hosting) replaces WordPress, ngit replaces GitHub"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1ffa08cf-4c29-45b0-b130-0b5c707d52a4
---

Perry is migrating goosielabs.com from WordPress to a fully decentralized Nostr-based stack.

**Why:** Philosophical alignment with self-sovereignty and decentralization. WordPress is dead weight for a tile/app landing page.

**Phases:**
1. `nsite.goosielabs.com` subdomain first — WordPress stays intact as fallback
2. Build English landing page with tile/icon structure on nsite
3. Migrate all app content to Nostr events
4. Share events with public relays (not just own relay)
5. Cutover `goosielabs.com` root to nsite, retire WordPress
6. Replace GitHub with NIP-34 Nostr git (`ngit` tool)
7. End state: Claude pushes Nostr events directly — no file system or GitHub needed

**Tech stack:**
- Publishing: `nsyte` (Deno CLI) or `nsite-cli` (Node.js) — publishes Kind 34128 events
- File storage: Blossom server (blobs addressed by SHA256)
- Gateway: `lez/nsite` — serves nsite at `nsite.goosielabs.com`
- Relay: existing strfry at `wss://goosielabs.com/relay`
- Git: `ngit` for NIP-34 decentralized git repos

**NIP numbers:**
- Kind 34128 — nsite file index (path → SHA256)
- Kind 15128 — nsite root site manifest
- Kind 35128 — nsite named site manifest
- Kind 30617 — NIP-34 git repo announcement
- Kind 1617 — NIP-34 git patches

**Key finding:** Perry's pubkey is already whitelisted on the relay, so nsite and git events from his key are already accepted. No mandatory policy.js change needed — just add the new kinds for clarity.

**RAM:** ~1 GB available (404 Mi free + 1.4 Gi swap). Tight — be careful with new services.

**How to apply:** Track progress against the branch plan. Suggest next branch when current one is merged to main.
