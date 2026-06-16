# Recent Changes — last 7 days (2026-06-16 19:41)

## Server (home-deploy)
```
c11389bfa policy: allow guest kind:1 if t:skein-* + p-tag to a host
8af260c6e todo: skein NIP-17 upgrade for booking/callback privacy
c64367bbf deleteapp: strip icon-script + docs/config entries; clean stale refs to deleted apps
ebf985022 deleteapp: suppress bleed-through output, dot spinner during nsite publish
6cd88a603 deleteapp: numbered steps with progress messages, prompt returns cleanly
e2a3a893d Note proofofread rebuild needed (old pre-newapp structure)
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
```

## Apps

### bookwriter
```
b44d15e Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### dilemma
```
0fa07ba Update icon: AI bird's-eye forking path landscape
```

### feedback
```
8873459 Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### gameofthegoose
```
65d0495 icons: regenerate with AERIAL style
bd972b1 Update icon: AI-generated board game landscape (top-down view, no goose)
843950d feat: translate all Dutch UI text to English
77fba07 fix: translate loading states to English
1205e89 fix: simplify lobby subtitle to English
2ffb8d3 fix: replace Ganzenbord with Game of the Goose in UI and HTML
8068018 fix: translate empty lobby state to English
9844624 fix: rename "Nieuwe kamer" → "New Game" in lobby
737a3cd feat: replace hardcoded colors with CSS variables for theme support
```

### georgie
```
40491a7 icons: regenerate with AERIAL style
32ea18b Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### honkbadge
```
49c2f11 icons: regenerate with AERIAL style
58fb408 Update icon: AI bird's-eye destination illustration (gpt-image-1)
d6c1d44 Fix icon: proper color+emoji, update tile.json icon_bg
```

### honkensus
```
97a76d0 icons: regenerate with AERIAL style
734d7e2 Update icon: AI bird's-eye destination illustration (gpt-image-1)
f9fa21f Voeg theme-support toe: inline kleuren vervangen door CSS variabelen
```

### honkference
```
828386b icons: regenerate with AERIAL style
af9d45b Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### lastwill
```
4e5c4c9 icons: regenerate with hourglass + sealed-letter (AERIAL style)
73563f3 Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### mint
```
4379a46 Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### newapp
```
8e24ad7 build: strip markdown fences + raise max_tokens for Index.tsx
0bef22f build: AERIAL icons + short tile descriptions
580b94d newapp-web: pass emojiGlyph option through to generate-icons, sync icons/ dir
2c0da66 cost: optimize Claude calls — Opus for generation, Haiku for refinement
```

### proofofmove
```
1b5e98e Update icon: AI bird's-eye destination illustration (gpt-image-1)
```

### proofofread
```
1e1e7d3 Update icon: AI bird's-eye destination illustration (gpt-image-1)
bca1340 Restore correct icon: dark green #065f46 with book emoji
70d9a3b Clean up tessa scripts, update icons, add publish-honk script
54d34a1 Add badge.svg — dark green seal with goose, shown on njump.me badge awards
7655a02 Publish badges via WebSocket to public relays — HTTP doesn't work there
d1c17b2 Speed up quiz + add direct badge URL
8542ee0 Handle HTML response on claim — show wallet-check message instead of JSON error
80ce72f Lowercase Lightning address before LNURL lookup — fixes Transy@ vs transy@
08d0833 Improve error messages when payment fails
9800700 Use hex pubkey in URLs instead of npub — Amethyst intercepts npub1...
```

### satquiz
```
9718bae icons: regenerate with AERIAL style
3e3b7fc Update icon: AI bird's-eye destination illustration (gpt-image-1)
ed73b52 Fix icon: proper color+emoji, update tile.json icon_bg
```

### skein
```
e595799 tile: tighter copy — 'right people and resources… your data stays yours'
9cd6ac1 tile: clearer description — emphasise event + privacy of personal info
d5a1710 auth: drop nostr-login (the 3rd-party overlay) entirely
9a14db4 logout: signal nostr-login + clear guest nsec so re-login works
94b20a6 booking: real 60/90-min candidate slots + visitor name & contact
b5f5d83 static QR landing pages for sharing the booking flows
0336340 footer: discrete Host link as login entry
1a0ddfb hide LoginArea from public view — host login only via ?host=1
6deb298 host check: accept both zoomer (old) and active npub as Perry
cbf0c61 host view: render and download QR codes for both flows
```

### toddy
```
6b4a8da icons: regenerate with AERIAL style
c33afb5 Update icon: AI bird's-eye destination illustration (gpt-image-1)
57b2252 Fix icon: proper color+emoji, update tile.json icon_bg
```

### zaphunt
```
5865769 backy: backup status 20260616_030001 [status=ok]
c134675 backy: backup status 20260615_030001 [status=ok]
5db659d Update icon: AI bird's-eye destination illustration (gpt-image-1)
2b1798e backy: backup status 20260614_030001 [status=ok]
0437c72 backy: backup status 20260613_030001 [status=ok]
716c7bd backy: backup status 20260612_030000 [status=ok]
4ff7348 backy: backup status 20260611_030002 [status=ok]
71458e5 fix: always copy locales to dist after build
13d7bf1 fix: load zaphunt namespace in i18n config
8123ef2 fix: complete i18n coverage — all Dutch strings replaced
```

### zinin
```
5c1015a Update icon: AI bird's-eye destination illustration (gpt-image-1)
```
