# Recent Changes — last 7 days (2026-06-09 19:54)

## Server (home-deploy)
```
201baf9fd Voeg theme-regel toe: altijd CSS variabelen, nooit hardcoded hex
1141aa66a chore: day summary — config, aliases, memory updates
52d9a7d12 todo: split wallet — donaties aan Perry verdelen over alle ganzen
236827691 cleanup: remove perry_zoomer — single Nostr identity (perry_goosie)
582037c24 fix: add kind:1060 (NIP-17 seal) to OPEN_KINDS in relay write policy
6b64f6a85 fix: add kind:10050 and kind:10002 to OPEN_KINDS in relay write policy
ea8af319e todo: bekijk Claude design plaatjes voor ganzen-portretten
50c4601b3 docs: add nano /home/deploy/.env.services path everywhere it's referenced
02b8b79db docs: API key management convention + inventory in CLAUDE.md
348081713 docs: add kind:10050 DM relay list to newgoose checklist
a29b4a62f todo: 18 apps login wall → progressive onboarding
7bc711f2b docs: Perry uses Aka for NIP-07 login, not Alby
de5b610f3 Update boilerplate submodule: tile.json + DonateButton toegevoegd
23a6c4843 Agent memory files + Cssy onboarded (CSS design system goose)
b28f8eb53 feat: add canadian theme to template.css
7b0676181 feat: add Cssy — CSS design system goose
d24cc2269 Agent memory files updated
84c34b77e todo: banners alle ganzen — scene per gans, handmatig bouwen
2a94ff80e Agent memory files updated
1c58616ff todo: LND boek afmaken + onderzoek node-runner gemeenschappen
caf7c671f Agent memory files updated
2f977840d todo: Bookwriter epub+webshop roadmap; lessons: publishing model via Nostr+Lightning
28146d250 LND book: comprehensive channel management research
69657859a LND book: scaling plan — design for portability, phase 1→2
202b563e9 LND book: sovereignty vs stability tension — hybrid approach
6c46f920c LND book: add lesson about Umbrel app load + server investigation
3ac8306f7 Add lessons learned system + LND book with initial research
6752d8f7e Agent memory files updated
c19f17d4e todo: LND direct op LNbits + kanaalmanagement Umbrel
0d03f2ef0 CLAUDE.md: correct LNbits payment pattern — invoice + payment_hash WS
```

## Apps

### bookwriter
```
8001b61 fix: remove nostr-login init() — eliminates double login modal
91dfda8 fix: don't auto-trigger Nostr extension on page load
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
dda3a65 fix: remove nostr-login init() — eliminates double login modal
59dd40d fix: don't auto-trigger Nostr extension on page load
cd588ac fix: theme-aware colors + clean login
a530f71 feat: add lnbits_inkey to tile.json
9bb0672 feat: new DALL-E app icon — map pin with lightning bolt and catching hand
6145425 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
f985520 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
36faf20 feat(auth): boilerplate auth-componenten bijgewerkt
2e4e581 i18n: translate tile.json description to English
```

### dilemma
```
e128e70 fix: remove nostr-login init() — eliminates double login modal
75997b6 fix: don't auto-trigger Nostr extension on page load
1918dff fix: theme-aware colors — bg-background/card, text-foreground/muted
92d463d feat: add lnbits_inkey to tile.json
2a34c90 feat: new DALL-E app icon v2 — balance scale with lightning bounty
96d3d8f feat: new DALL-E app icon — crossroads with bounty
6cb2165 rename: scripts/tessa → scripts/testy
e37788f feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
24ee12e fix(AccountSwitcher): Fragment wrapper voor TSX-fout
ff78908 feat(auth): boilerplate auth-componenten bijgewerkt
```

### feedback
```
9582d7c fix: remove nostr-login init() — eliminates double login modal
23594d2 fix: don't auto-trigger Nostr extension on page load
525bba6 fix: theme-aware colors — bg-background/card, text-foreground/muted
ec34cec feat: add lnbits_inkey to tile.json
390fb5a feat: new DALL-E app icon — anonymous mask in speech bubble with lightning
72a58c0 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8abba7d fix(AccountSwitcher): Fragment wrapper voor TSX-fout
7fdc21e feat(auth): boilerplate auth-componenten bijgewerkt
0dacd44 i18n: translate tile.json description to English
```

### flocks
```
2f14725 fix: remove nostr-login init() — eliminates double login modal
f1bbade fix: don't auto-trigger Nostr extension on page load
d64fe97 fix: theme-aware colors — bg-background/card, text-foreground/muted
57f00f5 docs: add CLAUDE.md with Doel & Gebruik section
```

### gameofthegoose
```
1be6e11 fix: remove nostr-login init() — eliminates double login modal
9380dca fix: don't auto-trigger Nostr extension on page load
711ec38 fix: theme-aware colors — bg-background/card/muted, text-foreground/muted
4ccc7a9 feat: add lnbits_inkey to tile.json
e3c8240 fix: map game status 'active' → 'playing' for PlayerPanel
4098e1e feat: publish guest kind:0 with random name on first login
b1383ad fix: remove duplicate GuestBanner from individual pages
89b9e0c chore: update tile — new title, description and app URL
04210fb chore: track all project files + update CLAUDE.md documentation
f075417 refactor: unique room IDs + explicit close-old-rooms before create
```

### georgie
```
837b2fa fix: remove nostr-login init() — eliminates double login modal
015704f fix: don't auto-trigger Nostr extension on page load
1aeb772 fix: theme-aware colors + progressive onboarding in MemoriesPage
aedf417 feat: add lnbits_inkey to tile.json
a5bfee4 docs: add Doel & Gebruik section to CLAUDE.md
95e0af7 feat: new DALL-E app icon — Georgia map with trail and landmarks
8a8c369 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
d30c81b fix(AccountSwitcher): Fragment wrapper voor TSX-fout
06cb7cd feat(auth): boilerplate auth-componenten bijgewerkt
```

### gooseprogrammer
```
368bffe fix: remove nostr-login init() — eliminates double login modal
de221bf fix: don't auto-trigger Nostr extension on page load
8bf1184 fix: theme-aware colors + clean up unauthorized screen
339e89b feat: add lnbits_inkey to tile.json
cd4c93d docs: add Doel & Gebruik section to CLAUDE.md
7196e8f feat: new DALL-E app icon — terminal with code and gear
f363d6c chore: rename Danky → Devy in agents, backend, CLAUDE.md
59d6cc5 refactor: rename haitje→ay and tessa→testy references
3999cd6 rename: tessa → testy
3ab6819 rename: astrid → assistenty
```

### goosiemanager
```
ef02c8c fix: remove nostr-login init() — eliminates double login modal
98c2f5f fix: don't auto-trigger Nostr extension on page load
b3b966a fix: theme-aware colors — bg-background/muted, text-foreground/muted
25ebed5 feat: add lnbits_inkey to tile.json
387454a refactor: replace @nostr-dev-kit/ndk with nostr-tools SimplePool
617ec7c docs: add Doel & Gebruik section to CLAUDE.md
fc09b89 feat: Flocks tile op homepage
92903fb feat: mobile-friendly layout
9d497e6 fix: agent grid als default view, bootstrap niet-blokkerend
cb3fc2e feat: agents laden met echte npub/pubkey velden
```

### goosieruntime
```
aeb7b49 feat: add /honk endpoint for agent-signed Nostr publishing
98bfd66 feat: Phase 1 GoosieRuntime Node.js service
```

### honkbadge
```
52a7e9b fix: remove nostr-login init() — eliminates double login modal
4f24c62 fix: don't auto-trigger Nostr extension on page load
b6ac30a fix: theme-aware colors — bg-background/card, text-foreground/muted
d4200e4 feat: add lnbits_inkey to tile.json
809c40d feat: kind:30008 — 'Zet op profiel' knop na badge verdiend
a867ea7 fix: WebSocket polyfill voor Node.js 20 + auto-publish badge definitie
768ee4b feat: HonkBadge — NIP-58 badge minting via Lightning
```

### honkensus
```
f9fa21f Voeg theme-support toe: inline kleuren vervangen door CSS variabelen
2490bac Fix publish crash: gebruik mutateAsync ipv publish op UseMutationResult
4a55c11 fix: remove nostr-login init() — eliminates double login modal
759eaf0 fix: theme-aware colors (zinc→semantic) + no extension auto-popup
8f88607 fix: don't auto-trigger Nostr extension on page load
668e6e4 fix: theme-aware colors — bg-background/card, text-foreground/muted
80bebc9 Voeg donate button toe, update tile.json en CLAUDE.md
3e2e447 Maak tile aan en update app metadata
c4061fa Voeg mobiele bottom nav toe
4ca0f07 Voeg profielfoto's en display names toe via AuthorAvatar component
```

### honkference
```
edbb0d5 feat: Join Room opens HiveTalk directly in new tab — no iframe, no double login
4d2c310 fix: remove LoginArea from header — only HiveTalk login needed
1985bf9 fix: remove CSP + add manifest.json — NIP-07 extension blocked, manifest missing
e9361a4 fix: remove nostr-login init() — eliminates double login modal
44cada7 fix: don't auto-trigger Nostr extension on page load
bf51683 fix: theme-aware colors — bg-background/card, text-foreground/muted
1334839 feat: add lnbits_inkey to tile.json
73b1bec chore: rename tile title to Honkference
6e24c97 docs: add Doel & Gebruik section to CLAUDE.md
421358f feat: new DALL-E icon — conference table, speech bubbles, microphone
```

### honkstation
```
1517810 fix: remove nostr-login init() — eliminates double login modal
f09ce8a fix: don't auto-trigger Nostr extension on page load
3dab804 fix: theme-aware colors — bg-background/card, text-foreground/muted
1262449 docs: add CLAUDE.md with Doel & Gebruik section
```

### iris
```
c31388ec docs: add Doel & Gebruik section to DEVELOPMENT.md
```

### lastwill
```
23baa18 fix: remove nostr-login init() — eliminates double login modal
4df6666 fix: don't auto-trigger Nostr extension on page load
9d36c36 fix: theme-aware colors — bg-background/card, text-foreground/muted
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
6fed014 fix: remove nostr-login init() — eliminates double login modal
e4dcbb0 fix: don't auto-trigger Nostr extension on page load
43f7d0e fix: theme-aware colors — bg-background/card, text-foreground/muted
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
```

### satquiz
```
a3dc5e5 fix: remove nostr-login init() — eliminates double login modal
8c59ac5 fix: don't auto-trigger Nostr extension on page load
9a55499 feat: add lnbits_inkey to tile.json
52c832e chore: rename tile title to Satoshi Quiz
```

### sofia
```
a821b97 fix: remove nostr-login init() — eliminates double login modal
4b77a4b fix: don't auto-trigger Nostr extension on page load
98fc190 fix: theme-aware colors — bg-background/card, text-foreground/muted
d618efd feat: add lnbits_inkey to tile.json
606d364 feat: new DALL-E app icon — group around map with privacy shield
d9f5812 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
cdac2a7 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
f903617 feat(auth): boilerplate auth-componenten bijgewerkt
94fed5b i18n: translate tile.json description to English
```

### swarm
```
48ea111 fix: remove nostr-login init() — eliminates double login modal
c688977 fix: theme-aware colors — bg-background/card, text-foreground/muted
324b4f9 feat: add lnbits_inkey to tile.json
07895e5 fix: toon npub i.p.v. hex in agent-detailpaneel
1528d46 feat: sync all 17 agents — real pubkeys, expanded V-formation
f1f87ec feat: new DALL-E app icon — V-formation glowing network nodes
453a67d chore: rename Communi → Commy
1074361 feat: grotere tiles met DM-activiteit per gans in V-formatie
75fe074 fix: alle ESLint-fouten opgelost, alle tests groen
cf3bbca add tile.json en app icons voor homepage
```

### vformation
```
46f2de8 fix: remove nostr-login init() — eliminates double login modal
8ec38c7 fix: don't auto-trigger Nostr extension on page load
b66b21e feat: add lnbits_inkey to tile.json
3de4fd0 docs: add Doel & Gebruik section to CLAUDE.md
c7b8ed0 feat: new DALL-E app icon — live V-shape with pulsing nodes
0e9d87e chore: update Commy role description in gooseConfig.ts
8a780b7 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
be9f0c0 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
c4aaef6 feat(auth): boilerplate auth-componenten bijgewerkt
213773e feat: all role geese in dashboard — Astrid, Danky, Finny, Ruby, Checky, Communi, Designy, Nosty, Admission
```

### weddendat
```
721fb33 fix: remove nostr-login init() — eliminates double login modal
bad51ab fix: don't auto-trigger Nostr extension on page load
ae41dcb fix: theme-aware colors — bg-background/card, text-foreground/muted
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
5f7dadb fix: remove nostr-login init() — eliminates double login modal
217c579 fix: don't auto-trigger Nostr extension on page load
c39a6ed fix: theme-aware colors + remove dashboard login wall
5b3c188 backy: backup status 20260609_030002 [status=ok]
8e4a416 backy: backup status 20260608_030002 [status=ok]
e0beb46 feat: add lnbits_inkey to tile.json
742374c backy: backup status 20260607_030000 [status=ok]
13b91d6 backy: backup status 20260606_030003 [status=ok]
694cb87 backy: backup status 20260605_030000 [status=ok]
3bb1257 feat: new DALL-E app icon — treasure map with lightning bolt and magnifying glass
```

### zinin
```
89ea2c1 feat: add lnbits_inkey to tile.json
3a8b528 feat: new DALL-E app icon — matching speech bubbles with spark
8edae71 i18n: translate tile.json description to English
```
