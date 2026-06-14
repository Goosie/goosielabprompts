# Recent Changes — last 7 days (2026-06-14 14:30)

## Server (home-deploy)
```
249711884 deleteapp: add systemd service, todo, CLAUDE.md and project memory cleanup
9160dcc88 deleteapp: drain LNbits wallet to Perry before deleting
73a05b7af Session resume 2026-06-13 — relay expansion + NIP-04 fallback + wallet consolidation
b773a148b Update nostr-listener runtime logs — processed/rewarded state
6355af8b8 Update runtime logs — nostr-listener processed/rewarded state, finny usage
ea5aba54e Update agent tiles, portraits, and flock after Welcome goose addition
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
```

## Apps

### bookwriter
```
8001b61 fix: remove nostr-login init() — eliminates double login modal
91dfda8 fix: don't auto-trigger Nostr extension on page load
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
```

### dilemma
```
e128e70 fix: remove nostr-login init() — eliminates double login modal
75997b6 fix: don't auto-trigger Nostr extension on page load
1918dff fix: theme-aware colors — bg-background/card, text-foreground/muted
```

### feedback
```
9582d7c fix: remove nostr-login init() — eliminates double login modal
23594d2 fix: don't auto-trigger Nostr extension on page load
525bba6 fix: theme-aware colors — bg-background/card, text-foreground/muted
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
```

### gooseprogrammer
```
368bffe fix: remove nostr-login init() — eliminates double login modal
de221bf fix: don't auto-trigger Nostr extension on page load
8bf1184 fix: theme-aware colors + clean up unauthorized screen
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
```

### honkstation
```
1517810 fix: remove nostr-login init() — eliminates double login modal
f09ce8a fix: don't auto-trigger Nostr extension on page load
3dab804 fix: theme-aware colors — bg-background/card, text-foreground/muted
```

### lastwill
```
23baa18 fix: remove nostr-login init() — eliminates double login modal
4df6666 fix: don't auto-trigger Nostr extension on page load
9d36c36 fix: theme-aware colors — bg-background/card, text-foreground/muted
```

### newapp
```
2c0da66 cost: optimize Claude calls — Opus for generation, Haiku for refinement
```

### proofofmove
```
6fed014 fix: remove nostr-login init() — eliminates double login modal
e4dcbb0 fix: don't auto-trigger Nostr extension on page load
43f7d0e fix: theme-aware colors — bg-background/card, text-foreground/muted
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
```

### sofia
```
a821b97 fix: remove nostr-login init() — eliminates double login modal
4b77a4b fix: don't auto-trigger Nostr extension on page load
98fc190 fix: theme-aware colors — bg-background/card, text-foreground/muted
```

### swarm
```
48ea111 fix: remove nostr-login init() — eliminates double login modal
c688977 fix: theme-aware colors — bg-background/card, text-foreground/muted
```

### vformation
```
46f2de8 fix: remove nostr-login init() — eliminates double login modal
8ec38c7 fix: don't auto-trigger Nostr extension on page load
```

### weddendat
```
721fb33 fix: remove nostr-login init() — eliminates double login modal
bad51ab fix: don't auto-trigger Nostr extension on page load
ae41dcb fix: theme-aware colors — bg-background/card, text-foreground/muted
```

### zaphunt
```
2b1798e backy: backup status 20260614_030001 [status=ok]
0437c72 backy: backup status 20260613_030001 [status=ok]
716c7bd backy: backup status 20260612_030000 [status=ok]
4ff7348 backy: backup status 20260611_030002 [status=ok]
71458e5 fix: always copy locales to dist after build
13d7bf1 fix: load zaphunt namespace in i18n config
8123ef2 fix: complete i18n coverage — all Dutch strings replaced
e2aff84 feat: add LanguageSwitcher to Index and HuntPlay headers
8e71272 feat: add i18n — EN/NL/DE/ES translations (Transy)
6a37d29 backy: backup status 20260610_030000 [status=ok]
```
