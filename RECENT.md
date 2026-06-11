# Recent Changes — last 7 days (2026-06-11 19:21)

## Server (home-deploy)
```
6b833baaa Add Cssy's DALL-E generated icon via Designy
4cce9e64c Restore unique portrait images for 8 geese
235358625 Add Toddy commands to goosie help
bdc2beaff Update QR codes to use nostr: URI scheme
8f74cac79 Add QR codes to all geese tiles and pages
f661b0d2b Add Toddy TODO CLI to goosie help and fix alias path
e48884bff docs: clarify how to use PERRY_NSEC from bashrc.local for publishing scripts
c00e243e7 cleanup: remove Ganzenbord as separate goose, logic stays in app
addd82576 mark todo items complete: #2 #7 #8 #26
a468a911a refactor: number all todo items for easier tracking
7d6c4b18d docs: document sync-agents script for keeping agent prompts in sync
38aea013d feat: add sync-agents script to keep agent prompts in sync with agents.json
66deae5dd docs: update backup documentation — LNbits + offsite Umbrel copy
3ec6132ec feat: translate all prompts to English + fix Transy role
4bb5df622 feat: complete V-Formation prompt overhaul
66b9bcde5 docs: add Goosie Labs vision document
8ea925d2a docs: add LND backup instructions to goosie help and whenidie.md
dbbb075a5 todo: rename Purpose Connector to Skein, add MVP direction and name origin
e373ce27c todo: add Purpose Connector idea — geese as village matchmakers on Nostr
4638a3857 feat: add Creaty + multi-goose >> / << sparring convention
ce17f048f feat: add Thinky as sparring gate — new ideas go through Thinky first
ad1fc3a0a feat: add Thinky — creative sparring partner goose
201baf9fd Voeg theme-regel toe: altijd CSS variabelen, nooit hardcoded hex
1141aa66a chore: day summary — config, aliases, memory updates
52d9a7d12 todo: split wallet — donaties aan Perry verdelen over alle ganzen
236827691 cleanup: remove perry_zoomer — single Nostr identity (perry_goosie)
582037c24 fix: add kind:1060 (NIP-17 seal) to OPEN_KINDS in relay write policy
6b64f6a85 fix: add kind:10050 and kind:10002 to OPEN_KINDS in relay write policy
ea8af319e todo: bekijk Claude design plaatjes voor ganzen-portretten
50c4601b3 docs: add nano /home/deploy/.env.services path everywhere it's referenced
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
```

### catchzaps
```
c33e82f fix: always copy locales to dist after build — Vite doesn't re-copy static assets on content-only changes
3dd7335 fix: translate all remaining Dutch strings in CatchZaps
8ad2962 fix: load catchzaps namespace in i18n config
7d6f636 fix: translate remaining Dutch strings in CatchZaps
0ea9ade fix: add LanguageSwitcher to visible pages
31b9d34 feat: add i18n — EN/NL/DE/ES translations (Transy)
dda3a65 fix: remove nostr-login init() — eliminates double login modal
59dd40d fix: don't auto-trigger Nostr extension on page load
cd588ac fix: theme-aware colors + clean login
a530f71 feat: add lnbits_inkey to tile.json
```

### dilemma
```
e128e70 fix: remove nostr-login init() — eliminates double login modal
75997b6 fix: don't auto-trigger Nostr extension on page load
1918dff fix: theme-aware colors — bg-background/card, text-foreground/muted
92d463d feat: add lnbits_inkey to tile.json
2a34c90 feat: new DALL-E app icon v2 — balance scale with lightning bounty
96d3d8f feat: new DALL-E app icon — crossroads with bounty
```

### feedback
```
9582d7c fix: remove nostr-login init() — eliminates double login modal
23594d2 fix: don't auto-trigger Nostr extension on page load
525bba6 fix: theme-aware colors — bg-background/card, text-foreground/muted
ec34cec feat: add lnbits_inkey to tile.json
390fb5a feat: new DALL-E app icon — anonymous mask in speech bubble with lightning
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
843950d feat: translate all Dutch UI text to English
77fba07 fix: translate loading states to English
1205e89 fix: simplify lobby subtitle to English
2ffb8d3 fix: replace Ganzenbord with Game of the Goose in UI and HTML
8068018 fix: translate empty lobby state to English
9844624 fix: rename "Nieuwe kamer" → "New Game" in lobby
737a3cd feat: replace hardcoded colors with CSS variables for theme support
1be6e11 fix: remove nostr-login init() — eliminates double login modal
9380dca fix: don't auto-trigger Nostr extension on page load
711ec38 fix: theme-aware colors — bg-background/card/muted, text-foreground/muted
```

### georgie
```
837b2fa fix: remove nostr-login init() — eliminates double login modal
015704f fix: don't auto-trigger Nostr extension on page load
1aeb772 fix: theme-aware colors + progressive onboarding in MemoriesPage
aedf417 feat: add lnbits_inkey to tile.json
a5bfee4 docs: add Doel & Gebruik section to CLAUDE.md
95e0af7 feat: new DALL-E app icon — Georgia map with trail and landmarks
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
```

### mint
```
4b41e39 feat: add lnbits_inkey to tile.json
0aba45b feat: Goosie Mint tile — icon, tile.json, links to mint.goosielabs.com
```

### newapp
```
2c0da66 cost: optimize Claude calls — Opus for generation, Haiku for refinement
a8918bd docs: add Doel & Gebruik section to CLAUDE.md
1ef1f60 chore: rename Danky → Devy in geese.ts, build.ts, Terminal.tsx, useBuild.ts, CLAUDE.md
```

### onboarding
```
334e49e feat: add lnbits_inkey to tile.json
bb6a765 docs: add Doel & Gebruik section to CLAUDE.md
6ce09f1 feat: new DALL-E app icon — identity card with sigil and key
```

### proofofmove
```
6fed014 fix: remove nostr-login init() — eliminates double login modal
e4dcbb0 fix: don't auto-trigger Nostr extension on page load
43f7d0e fix: theme-aware colors — bg-background/card, text-foreground/muted
2e8182f feat: add lnbits_inkey to tile.json
73a2666 feat: new DALL-E app icon — warrior pose with movement shadow and lightning
```

### proofofread
```
1aa06d1 feat: add lnbits_inkey to tile.json
753d0f2 feat: new DALL-E app icon — book, barcode, badge and lightning
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
```

### swarm
```
48ea111 fix: remove nostr-login init() — eliminates double login modal
c688977 fix: theme-aware colors — bg-background/card, text-foreground/muted
324b4f9 feat: add lnbits_inkey to tile.json
07895e5 fix: toon npub i.p.v. hex in agent-detailpaneel
1528d46 feat: sync all 17 agents — real pubkeys, expanded V-formation
f1f87ec feat: new DALL-E app icon — V-formation glowing network nodes
```

### vformation
```
46f2de8 fix: remove nostr-login init() — eliminates double login modal
8ec38c7 fix: don't auto-trigger Nostr extension on page load
b66b21e feat: add lnbits_inkey to tile.json
3de4fd0 docs: add Doel & Gebruik section to CLAUDE.md
c7b8ed0 feat: new DALL-E app icon — live V-shape with pulsing nodes
```

### weddendat
```
721fb33 fix: remove nostr-login init() — eliminates double login modal
bad51ab fix: don't auto-trigger Nostr extension on page load
ae41dcb fix: theme-aware colors — bg-background/card, text-foreground/muted
c450414 feat: add lnbits_inkey to tile.json
1fff08d feat: rename to I Bet That + new DALL-E icon (handshake/lightning/coins)
```

### zaphunt
```
4ff7348 backy: backup status 20260611_030002 [status=ok]
71458e5 fix: always copy locales to dist after build
13d7bf1 fix: load zaphunt namespace in i18n config
8123ef2 fix: complete i18n coverage — all Dutch strings replaced
e2aff84 feat: add LanguageSwitcher to Index and HuntPlay headers
8e71272 feat: add i18n — EN/NL/DE/ES translations (Transy)
6a37d29 backy: backup status 20260610_030000 [status=ok]
5f7dadb fix: remove nostr-login init() — eliminates double login modal
217c579 fix: don't auto-trigger Nostr extension on page load
c39a6ed fix: theme-aware colors + remove dashboard login wall
```

### zinin
```
89ea2c1 feat: add lnbits_inkey to tile.json
3a8b528 feat: new DALL-E app icon — matching speech bubbles with spark
```
