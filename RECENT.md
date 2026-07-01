# Recent Changes — last 7 days (2026-07-01 18:51)

## Server (home-deploy)
```
f96a506a todo: resolve Gitea token — refreshed + verified, mirror working (nosterin created), fallback aligned
df3af7f3 todo: close #27 (old pubkey retired), #21 (mijnapp removed), #11 (Phoenix 1500 sats)
e0f027a5 Version-control ~/.local/bin scripts (17 files)
6d2376cb todo: close #29 (relay whitelist) — agent fixed, policy tested, sync-configs preserves admissions
da41dae4 todo: tick Start here icon sub-item (AERIAL archway shipped)
d091885a todo: log stale GITEA_TOKEN / broken Gitea mirror (surfaced during NosterIn baseline)
81dbbbbf whenidie: WordPress fully decommissioned — drop the two WP mentions, bump review date to 2026-07-01
61781f69 docs: remove WordPress — decommissioned (no files, no DB, no services)
db178ba9 docs: App Icons section now documents the AERIAL pipeline as standard; flat-glyph generate-icons.mjs marked deprecated
053580b9 todo: freshen header (English, Conductor, put on #todo) + normalize tags (#idee→#idea, #tessa→#testy, #juridisch→#legal)
4ac78917 todo: log 3-stage Start here → Bookwriter → ProofOfRead roadmap; tick nosty.md review done
be080b06 Mission: raise the 'undismissible' bar from demo-applause to one real returning user
60843ea4 Nosty: real per-goosie key model, not fabricated AWS-signing; park Docy idea
d4862847 flock: rename Docy → Admitty (the admission gatekeeper) — identity, prompt, flock tables, agents.json
406b209d docs: GitHub auth is now via the gh CLI (gh auth setup-git), not ~/.git-credentials — update CLAUDE.md + whenidie.md; removed the empty credentials file + store helper
97238a1f audit: 'judge by runtime, not file layout' rule — Ay + prune-goosies memory (a missing scripts/ dir is weak; a live service is strong, e.g. Welcome in nostr-listener)
6dd38105 directory: add Level-1 proactive triggers ('Acts on its own when' — focus-drift, Gander scouting, idea clears Thinky's gate)
eb9ac032 prompts: tighten Directory — keep as the long-horizon/strategy lens, drop the Formation-Health overlap (that's Ay/Conductor)
8f8c9d68 flock: merge Prompty into Ay — Ay now audits AND refines prompts; idea→brief script kept as the 'ideabrief' tool; deletegoose prompty (28→27)
ed8afba1 flock: merge Checky into the Conductor — coordination/routing/triage is the main session's job; deletegoose checky (29→28); Ay handoff updated
965e9e21 flock: merge Gitea into Gitty — Gitty now owns GitHub + the self-hosted Gitea mirror; deletegoose gitea (30→29)
f4fe2a6f flock: retire Weathery, Linky, Supporty (right-sizing no-brainers) — remove identities, regen flock tables (33→30)
9ca5bf6b memory: Perry welcomes proactive advice to prune/merge goosies toward a leaner professional setup
7d8bf79b prompts: mechanical sweep across all goosie bodies — @<goose>→>><goose>, Assistenty(orchestrator)→the Conductor (body-only; flock tables + assistenty/toddy/transy/nosty preserved); agents.json about aligned
01d55a98 prompts: review Directory's body — @→>>, Assistenty→Conductor, align mission to 'undismissible demos', Directory advises (Perry decides), Thinky owns the new-idea gate
dd78b562 todo: queue a proper nosty.md body review (fabricated AWS-signing architecture → real key model)
6038ba4b vision.md: align to the Mission as NOW-vs-horizon (vision = horizon, demos = the seed); soften 'not to demonstrate tech' contradiction
ff33f6d1 prompts: humany — alert Assistenty → the Conductor (last orchestrator-ref ripple)
b69a838e prompts: review Ay's body — Assistenty→Conductor (4 spots), align 'vision' to the real Mission & Purpose (undismissible demos), drop conflicting vision.md reference
0a6e03d4 whenidie.md: add real family-recovery section (Rens & Mart authorized; 3 options; built on existing access procedures; one blank for key-custody only Perry knows)
```

## Apps

### bookwriter
```
4d50e1a tile: add GitHub source link
6ed6891 Remove dead WordPress MCP server
```

### dilemma
```
c787269 tile: add GitHub source link
9cc0432 Remove dead WordPress MCP server
```

### feedback
```
9b6afeb tile: add GitHub source link
51d6e7a Remove dead WordPress MCP server
```

### gameofthegoose
```
6fabc9e Remove dead WordPress MCP server
c1c6544 gooseAgents: complete the flock roster — refresh descriptions + add welcome, linky, Splitty, Skeiny
23bb2ed board: repoint removed-app squares — CatchZaps→Welcome, Sofia→Skein
```

### georgie
```
c56091c Remove dead WordPress MCP server
```

### honkbadge
```
a97c625 Remove dead WordPress MCP server
```

### honkensus
```
9b7a236 Remove dead WordPress MCP server
```

### honkference
```
66ba97d Remove dead WordPress MCP server
```

### honkstation
```
8d30813 Remove dead WordPress MCP server
```

### lastwill
```
b762dfc tile: add GitHub source link
9cf748b Remove dead WordPress MCP server
```

### newapp
```
76c10b9 Remove dead WordPress MCP server
```

### nosterin
```
015824a Remove dead WordPress MCP server
18364b7 Initial commit — NosterIn app
```

### proofofmove
```
6ba61f1 Remove dead WordPress MCP server
```

### proofofread
```
f1c6212 Merge: badge pass-gate fix
772d187 Gate badge + certificate on a pass, for every book
28ca777 journey redesign — Rungs A & B (give-first, panel fixes)
7a92072 hook: handle the returning user (don't say "earn 11 more" to someone at 21)
2713f2b hook: 60-second magic — 10 sats instant, then earn 11 more (with fogged path)
e37b1f2 onboarding honesty fixes (synthetic-user panel findings)
2e525f9 backup: show nsec alongside the 12 words + explain the difference
65bdd37 start done screen: show the badge + self-hosted verify + Step 3 (keep in wallet)
39abe05 onboarding: friendly, time-aware rate-limit message (no futile retry)
29fa594 ratelimit: env-based IP exempt list (ONBOARD_RATELIMIT_EXEMPT_IPS)
```

### satquiz
```
aa5c198 Remove dead WordPress MCP server
```

### skein
```
0869027 Remove dead WordPress MCP server
```

### zaphunt
```
ef25b17 Remove dead WordPress MCP server
3b6e1b7 backy: backup status 20260701_030000 [status=ok]
9cc8b92 backy: backup status 20260630_030000 [status=ok]
67818bf backy: backup status 20260629_030002 [status=ok]
991d8e2 backy: backup status 20260628_030002 [status=ok]
1bc36db backy: backup status 20260627_030002 [status=ok]
a8d9b8a backy: backup status 20260626_030001 [status=ok]
fa1d7a0 backy: backup status 20260625_030001 [status=ok]
```
