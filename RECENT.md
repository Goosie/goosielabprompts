# Recent Changes — last 7 days (2026-06-12 14:33)

## Server (home-deploy)
```
aa983bd79 Fix transparent PNGs for all geese + auto-regenerate on publish
c01ec68f1 Load PERRY_NSEC from ~/.perry-nsec keyfile in update-tiles.sh
03dcbd8ec Add transparent PNG portraits for all geese
705115387 Update listener and Finny logs after ProofOfRead flow testing
ce1f39174 Add Welcome goose — first contact for #goosielabs mentions on Nostr
c02547593 Sync adult portraits and whitelist
fd4f9ce0a Cartoon portraits for Toddy and Weathery
cf90424b4 Cartoon portraits for Thinky and Prompty
e1a94085a Add backy terminal command + update docs
4ade31992 Document goose portrait generation process
9c030a7bf Generate Coachy and Creaty's cartoon goose portraits
574ce6325 Cssy's proper cartoon goose portrait
c709ba42a Simplify Cssy's DALL-E icon prompt for consistency
172f554d8 Refine Cssy's DALL-E icon for visual consistency
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
```

## Apps

### bookwriter
```
8001b61 fix: remove nostr-login init() — eliminates double login modal
91dfda8 fix: don't auto-trigger Nostr extension on page load
31c31c6 feat: add lnbits_inkey to tile.json
8cb3692 chore: rename tile title to Write Book
fc4a266 docs: add Doel & Gebruik section to CLAUDE.md
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
```

### feedback
```
9582d7c fix: remove nostr-login init() — eliminates double login modal
23594d2 fix: don't auto-trigger Nostr extension on page load
525bba6 fix: theme-aware colors — bg-background/card, text-foreground/muted
ec34cec feat: add lnbits_inkey to tile.json
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
```

### gooseprogrammer
```
368bffe fix: remove nostr-login init() — eliminates double login modal
de221bf fix: don't auto-trigger Nostr extension on page load
8bf1184 fix: theme-aware colors + clean up unauthorized screen
339e89b feat: add lnbits_inkey to tile.json
cd4c93d docs: add Doel & Gebruik section to CLAUDE.md
```

### goosiemanager
```
ef02c8c fix: remove nostr-login init() — eliminates double login modal
98c2f5f fix: don't auto-trigger Nostr extension on page load
b3b966a fix: theme-aware colors — bg-background/muted, text-foreground/muted
25ebed5 feat: add lnbits_inkey to tile.json
387454a refactor: replace @nostr-dev-kit/ndk with nostr-tools SimplePool
617ec7c docs: add Doel & Gebruik section to CLAUDE.md
```

### goosieruntime
```
aeb7b49 feat: add /honk endpoint for agent-signed Nostr publishing
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
```

### mint
```
4b41e39 feat: add lnbits_inkey to tile.json
```

### newapp
```
2c0da66 cost: optimize Claude calls — Opus for generation, Haiku for refinement
a8918bd docs: add Doel & Gebruik section to CLAUDE.md
```

### onboarding
```
334e49e feat: add lnbits_inkey to tile.json
bb6a765 docs: add Doel & Gebruik section to CLAUDE.md
```

### proofofmove
```
6fed014 fix: remove nostr-login init() — eliminates double login modal
e4dcbb0 fix: don't auto-trigger Nostr extension on page load
43f7d0e fix: theme-aware colors — bg-background/card, text-foreground/muted
2e8182f feat: add lnbits_inkey to tile.json
```

### proofofread
```
70d9a3b Clean up tessa scripts, update icons, add publish-honk script
54d34a1 Add badge.svg — dark green seal with goose, shown on njump.me badge awards
7655a02 Publish badges via WebSocket to public relays — HTTP doesn't work there
d1c17b2 Speed up quiz + add direct badge URL
8542ee0 Handle HTML response on claim — show wallet-check message instead of JSON error
80ce72f Lowercase Lightning address before LNURL lookup — fixes Transy@ vs transy@
08d0833 Improve error messages when payment fails
9800700 Use hex pubkey in URLs instead of npub — Amethyst intercepts npub1...
5b7670a Pre-fill Lightning address on claim page + wallet suggestions
fb6e51b Pass npub through entire flow — pre-filled on claim page
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
```

### swarm
```
48ea111 fix: remove nostr-login init() — eliminates double login modal
c688977 fix: theme-aware colors — bg-background/card, text-foreground/muted
324b4f9 feat: add lnbits_inkey to tile.json
```

### vformation
```
46f2de8 fix: remove nostr-login init() — eliminates double login modal
8ec38c7 fix: don't auto-trigger Nostr extension on page load
b66b21e feat: add lnbits_inkey to tile.json
3de4fd0 docs: add Doel & Gebruik section to CLAUDE.md
```

### weddendat
```
721fb33 fix: remove nostr-login init() — eliminates double login modal
bad51ab fix: don't auto-trigger Nostr extension on page load
ae41dcb fix: theme-aware colors — bg-background/card, text-foreground/muted
c450414 feat: add lnbits_inkey to tile.json
```

### zaphunt
```
716c7bd backy: backup status 20260612_030000 [status=ok]
4ff7348 backy: backup status 20260611_030002 [status=ok]
71458e5 fix: always copy locales to dist after build
13d7bf1 fix: load zaphunt namespace in i18n config
8123ef2 fix: complete i18n coverage — all Dutch strings replaced
e2aff84 feat: add LanguageSwitcher to Index and HuntPlay headers
8e71272 feat: add i18n — EN/NL/DE/ES translations (Transy)
6a37d29 backy: backup status 20260610_030000 [status=ok]
5f7dadb fix: remove nostr-login init() — eliminates double login modal
217c579 fix: don't auto-trigger Nostr extension on page load
```

### zinin
```
89ea2c1 feat: add lnbits_inkey to tile.json
```
