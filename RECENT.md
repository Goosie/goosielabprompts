# Recent Changes — last 7 days (2026-06-08 18:58)

## Server (home-deploy)
```
69657859a LND book: scaling plan — design for portability, phase 1→2
202b563e9 LND book: sovereignty vs stability tension — hybrid approach
6c46f920c LND book: add lesson about Umbrel app load + server investigation
3ac8306f7 Add lessons learned system + LND book with initial research
6752d8f7e Agent memory files updated
c19f17d4e todo: LND direct op LNbits + kanaalmanagement Umbrel
0d03f2ef0 CLAUDE.md: correct LNbits payment pattern — invoice + payment_hash WS
9d2cf3a5a CLAUDE.md: fix LNbits WS URL — use inkey not wallet_id
385d5daa7 CLAUDE.md: LNbits WebSocket as standard pattern for payment UX
386654067 Agent memory files updated
0cb71d18a Agent memory + whitelist updates (gander added)
8a7c5fbb8 Gander: news scout goose — long-form articles + ideas to Directory
c9964d9c2 Agent memory files updated (blocky, healthy, humany, assistenty)
e84a29ed9 CLAUDE.md: document deletegoose command
b92c934ca Remove testy2 (test goose)
9a682029d CLAUDE.md: AGENT_ORDER + tile + flock prompts + ceremony now automated
c10c56fc0 whitelist.json: coachy added
780a959cb Coachy: encouragement goose — amber icon, description, nsite page
b8358808b CLAUDE.md: full newgoose checklist — automated + manual steps
a5088c581 Backy: nsite page live, tagline and tile
677c0d358 All geese: add description + blockbirth, Backy blockbirth #779142
c35e491d0 Backy: add icon, Nostr profile, homepage tile, agents.json description
61e9520ab >>backy snapshot shorthand for honk command
d992d32be Add ## Commands section to all geese + fix goosie function/script conflict
7a0381053 Add /flock slash command + >> alone shows goose overview
6dccca80f Convention: >> prefix voor ganzen (twee vleugels, niet één)
3d52999c8 CLAUDE.md: add Healthy to V-Formation table
bc6cf24f5 Docs: Blocky is the timer, healthy goose, live feed on homepage
08240ca64 Docs: Blocky is the timer — update all relevant prompts and docs
12f68b228 Add Healthy goose — proactive server health monitor
```

## Apps

### bookwriter
```
31c31c6 feat: add lnbits_inkey to tile.json
8cb3692 chore: rename tile title to Write Book
fc4a266 docs: add Doel & Gebruik section to CLAUDE.md
f1156e6 feat: new DALL-E app icon — open book with AI sparks and quill
2d154ca feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
d14a102 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
418c7d8 feat(auth): boilerplate auth-componenten bijgewerkt
6a45d1a i18n: translate tile.json description to English
```

### catchzaps
```
a530f71 feat: add lnbits_inkey to tile.json
9bb0672 feat: new DALL-E app icon — map pin with lightning bolt and catching hand
6145425 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
f985520 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
36faf20 feat(auth): boilerplate auth-componenten bijgewerkt
2e4e581 i18n: translate tile.json description to English
```

### dilemma
```
92d463d feat: add lnbits_inkey to tile.json
2a34c90 feat: new DALL-E app icon v2 — balance scale with lightning bounty
96d3d8f feat: new DALL-E app icon — crossroads with bounty
6cb2165 rename: scripts/tessa → scripts/testy
e37788f feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
24ee12e fix(AccountSwitcher): Fragment wrapper voor TSX-fout
ff78908 feat(auth): boilerplate auth-componenten bijgewerkt
c69e668 i18n: translate tile.json description to English
```

### feedback
```
ec34cec feat: add lnbits_inkey to tile.json
390fb5a feat: new DALL-E app icon — anonymous mask in speech bubble with lightning
72a58c0 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8abba7d fix(AccountSwitcher): Fragment wrapper voor TSX-fout
7fdc21e feat(auth): boilerplate auth-componenten bijgewerkt
0dacd44 i18n: translate tile.json description to English
```

### flocks
```
57f00f5 docs: add CLAUDE.md with Doel & Gebruik section
```

### gameofthegoose
```
4ccc7a9 feat: add lnbits_inkey to tile.json
e3c8240 fix: map game status 'active' → 'playing' for PlayerPanel
4098e1e feat: publish guest kind:0 with random name on first login
b1383ad fix: remove duplicate GuestBanner from individual pages
89b9e0c chore: update tile — new title, description and app URL
04210fb chore: track all project files + update CLAUDE.md documentation
f075417 refactor: unique room IDs + explicit close-old-rooms before create
480a73c fix: NIP-40 expiration on GameRoom events + tighter since window
df6f791 docs: add relay + room-id rules to CLAUDE.md
131d91d fix: single relay + immediate room render via navigation state
```

### georgie
```
aedf417 feat: add lnbits_inkey to tile.json
a5bfee4 docs: add Doel & Gebruik section to CLAUDE.md
95e0af7 feat: new DALL-E app icon — Georgia map with trail and landmarks
8a8c369 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
d30c81b fix(AccountSwitcher): Fragment wrapper voor TSX-fout
06cb7cd feat(auth): boilerplate auth-componenten bijgewerkt
```

### gooseprogrammer
```
339e89b feat: add lnbits_inkey to tile.json
cd4c93d docs: add Doel & Gebruik section to CLAUDE.md
7196e8f feat: new DALL-E app icon — terminal with code and gear
f363d6c chore: rename Danky → Devy in agents, backend, CLAUDE.md
59d6cc5 refactor: rename haitje→ay and tessa→testy references
3999cd6 rename: tessa → testy
3ab6819 rename: astrid → assistenty
0012b43 chore: rename Communi → Commy
1316266 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8f3db3a fix(AccountSwitcher): Fragment wrapper voor TSX-fout
```

### goosiemanager
```
25ebed5 feat: add lnbits_inkey to tile.json
387454a refactor: replace @nostr-dev-kit/ndk with nostr-tools SimplePool
617ec7c docs: add Doel & Gebruik section to CLAUDE.md
fc09b89 feat: Flocks tile op homepage
92903fb feat: mobile-friendly layout
9d497e6 fix: agent grid als default view, bootstrap niet-blokkerend
cb3fc2e feat: agents laden met echte npub/pubkey velden
f1f14cc feat: Phase 1 GoosieManager frontend
```

### goosieruntime
```
aeb7b49 feat: add /honk endpoint for agent-signed Nostr publishing
98bfd66 feat: Phase 1 GoosieRuntime Node.js service
```

### honkbadge
```
d4200e4 feat: add lnbits_inkey to tile.json
809c40d feat: kind:30008 — 'Zet op profiel' knop na badge verdiend
a867ea7 fix: WebSocket polyfill voor Node.js 20 + auto-publish badge definitie
768ee4b feat: HonkBadge — NIP-58 badge minting via Lightning
```

### honkference
```
1334839 feat: add lnbits_inkey to tile.json
73b1bec chore: rename tile title to Honkference
6e24c97 docs: add Doel & Gebruik section to CLAUDE.md
421358f feat: new DALL-E icon — conference table, speech bubbles, microphone
4f29c76 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
5cb5033 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
f59e973 feat(auth): boilerplate auth-componenten bijgewerkt
a565fdb goosielab update 2026-06-02 15:44
```

### honkstation
```
1262449 docs: add CLAUDE.md with Doel & Gebruik section
```

### iris
```
c31388ec docs: add Doel & Gebruik section to DEVELOPMENT.md
```

### lastwill
```
6c31f1c feat: add lnbits_inkey to tile.json
d6b3aca feat: new app icon — flat cartoon testament/heartbeat/padlock via DALL-E
ab0f069 rename: scripts/tessa → scripts/testy
d44b4bd feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8f07347 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
4bf426c feat(auth): boilerplate auth-componenten bijgewerkt
fe71996 i18n: translate tile.json description to English
```

### mijnapp
```
22dd41b feat: initiële commit mijnapp
17ed149 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
18acc47 feat(auth): boilerplate auth-componenten bijgewerkt
```

### mint
```
4b41e39 feat: add lnbits_inkey to tile.json
0aba45b feat: Goosie Mint tile — icon, tile.json, links to mint.goosielabs.com
```

### newapp
```
a8918bd docs: add Doel & Gebruik section to CLAUDE.md
1ef1f60 chore: rename Danky → Devy in geese.ts, build.ts, Terminal.tsx, useBuild.ts, CLAUDE.md
d043e10 rename: tessa → testy
7441613 rename: fix remaining addLog astrid → assistenty in useBuild.ts
46a8ffc rename: astrid → assistenty
8e53640 chore: rename Communi → Commy
2177698 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
e04c719 fix: uitlogknop bij geen toegang zodat je ander account kunt proberen
b3953dd fix: pubkey checken voor inloggen, directe foutmelding bij verkeerde nsec
5a808cb fix: nostr-login init() verwijderd — extensie direct via window.nostr
```

### onboarding
```
334e49e feat: add lnbits_inkey to tile.json
bb6a765 docs: add Doel & Gebruik section to CLAUDE.md
6ce09f1 feat: new DALL-E app icon — identity card with sigil and key
11f15a7 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
```

### proofofmove
```
2e8182f feat: add lnbits_inkey to tile.json
73a2666 feat: new DALL-E app icon — warrior pose with movement shadow and lightning
bfbae7d feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
36d33a9 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
6cb650f feat(auth): boilerplate auth-componenten bijgewerkt
f02c3fc i18n: translate tile.json description to English
```

### proofofread
```
1aa06d1 feat: add lnbits_inkey to tile.json
753d0f2 feat: new DALL-E app icon — book, barcode, badge and lightning
b642c75 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
9d82c1d feat: tessa script aangemaakt — check + seed
```

### satquiz
```
9a55499 feat: add lnbits_inkey to tile.json
52c832e chore: rename tile title to Satoshi Quiz
```

### sofia
```
d618efd feat: add lnbits_inkey to tile.json
606d364 feat: new DALL-E app icon — group around map with privacy shield
d9f5812 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
cdac2a7 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
f903617 feat(auth): boilerplate auth-componenten bijgewerkt
94fed5b i18n: translate tile.json description to English
```

### swarm
```
324b4f9 feat: add lnbits_inkey to tile.json
07895e5 fix: toon npub i.p.v. hex in agent-detailpaneel
1528d46 feat: sync all 17 agents — real pubkeys, expanded V-formation
f1f87ec feat: new DALL-E app icon — V-formation glowing network nodes
453a67d chore: rename Communi → Commy
1074361 feat: grotere tiles met DM-activiteit per gans in V-formatie
75fe074 fix: alle ESLint-fouten opgelost, alle tests groen
cf3bbca add tile.json en app icons voor homepage
417e94a feat: Swarm V-formatie dashboard met live Nostr DM visualisatie
```

### vformation
```
b66b21e feat: add lnbits_inkey to tile.json
3de4fd0 docs: add Doel & Gebruik section to CLAUDE.md
c7b8ed0 feat: new DALL-E app icon — live V-shape with pulsing nodes
0e9d87e chore: update Commy role description in gooseConfig.ts
8a780b7 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
be9f0c0 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
c4aaef6 feat(auth): boilerplate auth-componenten bijgewerkt
213773e feat: all role geese in dashboard — Astrid, Danky, Finny, Ruby, Checky, Communi, Designy, Nosty, Admission
6c5c2fa feat: Gitea onboarded via Humany newgoose
e30d55c feat: Gitty onboarded via Humany newgoose
```

### weddendat
```
c450414 feat: add lnbits_inkey to tile.json
1fff08d feat: rename to I Bet That + new DALL-E icon (handshake/lightning/coins)
d3e0a70 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
54f602b fix(AccountSwitcher): Fragment wrapper voor TSX-fout
19f503a feat(auth): boilerplate auth-componenten bijgewerkt
eee75e7 i18n: translate tile.json description to English
```

### zap-hunt
```
e4278e8 rename: scripts/tessa → scripts/testy
47b1094 feat: add Tessa test agent
```

### zaphunt
```
8e4a416 backy: backup status 20260608_030002 [status=ok]
e0beb46 feat: add lnbits_inkey to tile.json
742374c backy: backup status 20260607_030000 [status=ok]
13b91d6 backy: backup status 20260606_030003 [status=ok]
694cb87 backy: backup status 20260605_030000 [status=ok]
3bb1257 feat: new DALL-E app icon — treasure map with lightning bolt and magnifying glass
d8e1ee1 backy: backup status 20260604_030003 [status=ok]
2d5d04f feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
2e3e3e9 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
3135323 feat(auth): boilerplate auth-componenten bijgewerkt
```

### zinin
```
89ea2c1 feat: add lnbits_inkey to tile.json
3a8b528 feat: new DALL-E app icon — matching speech bubbles with spark
8edae71 i18n: translate tile.json description to English
```
