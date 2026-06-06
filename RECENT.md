# Recent Changes — last 7 days (2026-06-06 18:04)

## Server (home-deploy)
```
011fa647d relay policy: open game event kinds for all players
208bc1030 todo: auth-patronen standaardiseren in newapp workflow
0d731f2f5 chore: update configs, add tile templates, agent images and gitignore secrets
c95157766 todo: add ganzenbord game idea
8bc6f2dca fix: add 500ms delay between payments to avoid NWC rate limiting on Alby Hub
93fd0fceb feat: add perry@goosielabs.com Lightning Address
b5a7cf5d4 fix: use Lightning Addresses (name@goosielabs.com) in send-sats-to-geese
fb8c6a93e feat: add Testy script to send 3 sats to all geese
196b15255 fix: renew LNbits wallet links for all goosies after reinstall
33c6ade70 chore: add quotes to all goosie agent .md files
dd70237e9 feat: add full prompt pages for blocky, directory, supporty; tile quotes for all geese
44dd4dd3a chore: update Assistenty tile description
9bd76ae9d chore: rename Danky → Devy — agent dir, images, CLAUDE.md
cfd91ef28 refactor: rename goose ruby → transy (agents dir + CLAUDE.md)
ae8aa7a50 refactor: rename goose admission → docy (agents dir + CLAUDE.md)
58fe049fd refactor: update server CLAUDE.md for haitje→ay, tessa→testy, astrid→assistenty
cd7c4aab8 refactor: rename goose haitje → ay (agents dir + CLAUDE.md)
c907ae5af rename: tessa → testy across home-deploy
6fb29bc15 rename: fix remaining Astrid references in publish-badges.js and publish-profiles.js
2c774572d rename: astrid → assistenty across systemsetup scripts
3fb11177a rename: astrid → assistenty across home-deploy
47a46544b chore: update all agent tile.html files — nsite links refreshed by publish-agent-pages
5343ba6fa chore: update tile.html — publish-agent-pages auto-updated nsite link
4a1d2b2e2 chore: rename Communi → Commy in remaining files
dab92c8b3 chore: add commy.md with role description
175f1b307 chore: update Commy description — Community manager, honking wherever I can
84be4f55b feat: rename Communi → Commy across all systems
ca7327aa2 feat: onboard Supporty — keypair, icon, wallet, NIP-05, whitelist
04733dd6f chore: add Directory to agents.json and whitelist
19a38bdee feat(directory): LNbits wallet + Lightning Address
```

## Apps

### bookwriter
```
f1156e6 feat: new DALL-E app icon — open book with AI sparks and quill
2d154ca feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
d14a102 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
418c7d8 feat(auth): boilerplate auth-componenten bijgewerkt
6a45d1a i18n: translate tile.json description to English
6b546c3 refactor: remove old login UI, keep modular nostr-login auth
3014bdd fix: add missing nostr-login dependency after auth sync
910e802 chore: sync auth components from boilerplate
92b1d52 security: add *.db *.sqlite to gitignore
544b3fb security: untrack dvm.key + add to gitignore
```

### catchzaps
```
9bb0672 feat: new DALL-E app icon — map pin with lightning bolt and catching hand
6145425 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
f985520 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
36faf20 feat(auth): boilerplate auth-componenten bijgewerkt
2e4e581 i18n: translate tile.json description to English
223d47e fix: add missing nostr-login dependency that caused blank page
a14ed15 fix: handle non-JSON server responses in API requests
df6bd74 chore: sync auth components from boilerplate
2fe16d2 security: untrack database + add *.db to gitignore
31e34ec feat: progressive onboarding — remove login wall, add write gate
```

### dilemma
```
2a34c90 feat: new DALL-E app icon v2 — balance scale with lightning bounty
96d3d8f feat: new DALL-E app icon — crossroads with bounty
6cb2165 rename: scripts/tessa → scripts/testy
e37788f feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
24ee12e fix(AccountSwitcher): Fragment wrapper voor TSX-fout
ff78908 feat(auth): boilerplate auth-componenten bijgewerkt
c69e668 i18n: translate tile.json description to English
38f5d9f fix: add missing nostr-login dependency — blank page on load
d0b04a1 chore: sync auth components from boilerplate
6482796 security: add *.db *.sqlite to gitignore
```

### feedback
```
390fb5a feat: new DALL-E app icon — anonymous mask in speech bubble with lightning
72a58c0 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8abba7d fix(AccountSwitcher): Fragment wrapper voor TSX-fout
7fdc21e feat(auth): boilerplate auth-componenten bijgewerkt
0dacd44 i18n: translate tile.json description to English
dbd953f fix: add missing nostr-login dependency — blank page on load
4b02448 chore: sync auth components from boilerplate
28442f4 security: add *.db *.sqlite to gitignore
3bb2491 feat: progressive onboarding — remove login wall, add write gate
```

### gameofthegoose
```
2214801 fix: room creation navigates to waiting room immediately (optimistic UI)
453dbcd step 7: live board — BoardConfig from Nostr updates all games in real time
89cc394 add guest play flow — instant one-click play without Nostr account
d61c659 fix login UX: direct extension access, clickable auth triggers in lobby
03c31fa improve AuthDialog: flat login method selector, all options always visible
9e2838d step 6: visual polish — animations, overlays, winner screen
e64dd65 step 5: game loop — roll → Nostr → animate → board update
8be0c3f step 4: lobby — create/join rooms via Nostr
1912dbf step 3: nostr game server
7bec00e step 2: static board rendering — component split + visual polish
```

### georgie
```
95e0af7 feat: new DALL-E app icon — Georgia map with trail and landmarks
8a8c369 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
d30c81b fix(AccountSwitcher): Fragment wrapper voor TSX-fout
06cb7cd feat(auth): boilerplate auth-componenten bijgewerkt
5dea4b9 fix: add missing nostr-login dependency — blank page on load
99984a1 chore: sync auth components from boilerplate
23e5108 security: add *.db *.sqlite to gitignore
c97193a feat: progressive onboarding — remove login wall, add write gate
```

### gooseprogrammer
```
7196e8f feat: new DALL-E app icon — terminal with code and gear
f363d6c chore: rename Danky → Devy in agents, backend, CLAUDE.md
59d6cc5 refactor: rename haitje→ay and tessa→testy references
3999cd6 rename: tessa → testy
3ab6819 rename: astrid → assistenty
0012b43 chore: rename Communi → Commy
1316266 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8f3db3a fix(AccountSwitcher): Fragment wrapper voor TSX-fout
a0e6bd7 feat(auth): boilerplate auth-componenten bijgewerkt
6aaddda feat: Goosie Programmer — agent control panel
```

### goosiemanager
```
fc09b89 feat: Flocks tile op homepage
92903fb feat: mobile-friendly layout
9d497e6 fix: agent grid als default view, bootstrap niet-blokkerend
cb3fc2e feat: agents laden met echte npub/pubkey velden
f1f14cc feat: Phase 1 GoosieManager frontend
```

### goosieruntime
```
98bfd66 feat: Phase 1 GoosieRuntime Node.js service
```

### honkbadge
```
809c40d feat: kind:30008 — 'Zet op profiel' knop na badge verdiend
a867ea7 fix: WebSocket polyfill voor Node.js 20 + auto-publish badge definitie
768ee4b feat: HonkBadge — NIP-58 badge minting via Lightning
```

### honkference
```
421358f feat: new DALL-E icon — conference table, speech bubbles, microphone
4f29c76 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
5cb5033 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
f59e973 feat(auth): boilerplate auth-componenten bijgewerkt
a565fdb goosielab update 2026-06-02 15:44
76f20d4 fix: add missing nostr-login dependency — blank page on load
96f18c2 chore: sync auth components from boilerplate
35b9a9f security: add *.db *.sqlite to gitignore
802c4fc feat: progressive onboarding — remove login wall, add write gate
```

### lastwill
```
d6b3aca feat: new app icon — flat cartoon testament/heartbeat/padlock via DALL-E
ab0f069 rename: scripts/tessa → scripts/testy
d44b4bd feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
8f07347 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
4bf426c feat(auth): boilerplate auth-componenten bijgewerkt
fe71996 i18n: translate tile.json description to English
79c8f08 fix: add missing nostr-login dependency — blank page on load
55c8b3b chore: sync auth components from boilerplate
123e0e5 security: add *.db *.sqlite to gitignore
c235d14 feat: progressive onboarding — remove login wall, add write gate
```

### mijnapp
```
22dd41b feat: initiële commit mijnapp
17ed149 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
18acc47 feat(auth): boilerplate auth-componenten bijgewerkt
```

### mint
```
0aba45b feat: Goosie Mint tile — icon, tile.json, links to mint.goosielabs.com
```

### newapp
```
1ef1f60 chore: rename Danky → Devy in geese.ts, build.ts, Terminal.tsx, useBuild.ts, CLAUDE.md
d043e10 rename: tessa → testy
7441613 rename: fix remaining addLog astrid → assistenty in useBuild.ts
46a8ffc rename: astrid → assistenty
8e53640 chore: rename Communi → Commy
2177698 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
e04c719 fix: uitlogknop bij geen toegang zodat je ander account kunt proberen
b3953dd fix: pubkey checken voor inloggen, directe foutmelding bij verkeerde nsec
5a808cb fix: nostr-login init() verwijderd — extensie direct via window.nostr
123713d fix: bridge laat opgeslagen sessie met rust, geen dubbele login meer
```

### onboarding
```
6ce09f1 feat: new DALL-E app icon — identity card with sigil and key
11f15a7 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
c13ba97 initialize
422e027 security: add *.db *.sqlite to gitignore
```

### proofofmove
```
73a2666 feat: new DALL-E app icon — warrior pose with movement shadow and lightning
bfbae7d feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
36d33a9 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
6cb650f feat(auth): boilerplate auth-componenten bijgewerkt
f02c3fc i18n: translate tile.json description to English
0d4e773 fix: remove nostr-login dependency causing blank page on startup
ceefde9 chore: sync auth components from boilerplate
7b3cebd security: add *.db *.sqlite to gitignore
64b0d0a feat: progressive onboarding — remove login wall, add write gate
```

### proofofread
```
753d0f2 feat: new DALL-E app icon — book, barcode, badge and lightning
b642c75 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
9d82c1d feat: tessa script aangemaakt — check + seed
a4b8030 initial commit
```

### sofia
```
606d364 feat: new DALL-E app icon — group around map with privacy shield
d9f5812 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
cdac2a7 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
f903617 feat(auth): boilerplate auth-componenten bijgewerkt
94fed5b i18n: translate tile.json description to English
70b7b87 fix: remove nostr-login dependency causing blank page
ee8a3bd chore: sync auth components from boilerplate
76566ff security: add *.db *.sqlite to gitignore
282c119 feat: progressive onboarding — remove login wall, add write gate
```

### swarm
```
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
c7b8ed0 feat: new DALL-E app icon — live V-shape with pulsing nodes
0e9d87e chore: update Commy role description in gooseConfig.ts
8a780b7 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
be9f0c0 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
c4aaef6 feat(auth): boilerplate auth-componenten bijgewerkt
213773e feat: all role geese in dashboard — Astrid, Danky, Finny, Ruby, Checky, Communi, Designy, Nosty, Admission
6c5c2fa feat: Gitea onboarded via Humany newgoose
e30d55c feat: Gitty onboarded via Humany newgoose
c86c722 feat: Humany — formation HR goose, register in dashboard
5cd9730 feat: Chat tab — inter-goose formation messages
```

### weddendat
```
1fff08d feat: rename to I Bet That + new DALL-E icon (handshake/lightning/coins)
d3e0a70 feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
54f602b fix(AccountSwitcher): Fragment wrapper voor TSX-fout
19f503a feat(auth): boilerplate auth-componenten bijgewerkt
eee75e7 i18n: translate tile.json description to English
b9e2598 fix: add missing nostr-login dependency — blank page on load
a60ce68 chore: sync auth components from boilerplate
e834e4d security: add *.db *.sqlite to gitignore
6dd3de8 feat: progressive onboarding — remove login wall, add write gate
```

### zap-hunt
```
e4278e8 rename: scripts/tessa → scripts/testy
47b1094 feat: add Tessa test agent
```

### zaphunt
```
13b91d6 backy: backup status 20260606_030003 [status=ok]
694cb87 backy: backup status 20260605_030000 [status=ok]
3bb1257 feat: new DALL-E app icon — treasure map with lightning bolt and magnifying glass
d8e1ee1 backy: backup status 20260604_030003 [status=ok]
2d5d04f feat: relay URL bijgewerkt naar wss://relay.goosielabs.com
2e3e3e9 fix(AccountSwitcher): Fragment wrapper voor TSX-fout
3135323 feat(auth): boilerplate auth-componenten bijgewerkt
28e90fa backy: backup status 20260603_030004 [status=ok]
6d7f016 backy: backup status 20260602_202323 [status=partial]
d3c063e i18n: translate tile.json description to English
```

### zinin
```
3a8b528 feat: new DALL-E app icon — matching speech bubbles with spark
8edae71 i18n: translate tile.json description to English
55673f7 chore: add juridischadvies.html
ea4d2bc security: add .gitignore (was missing entirely)
```
