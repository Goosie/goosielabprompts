# Recent Changes — last 7 days (2026-06-30 09:38)

## Server (home-deploy)
```
dd626e3a prompts: fix + regenerate the flock tables — add Humany 'flock' command, fill missing source descriptions (gitea/gitty/weathery/prompty/toddy), correct Transy + Healthy
958e2f20 prompts: clean agent descriptions — Astrid→Assistenty everywhere, translate Toddy + Ay (+backy/transy) to English, sync agents.json
70bf8c6c CLAUDE.md: add 'AI coaching' rule — teach AI in context + 🤖 AI tips (Perry's 2nd mission: become a strong AI manager)
6f8a0782 CLAUDE.md: add 'Q: means answer-only' rule (a question gets an answer, no action)
15dba0d7 prompts: tie Assistenty's persona to the mission + refresh the flock roster (33 geese, add Splitty/Skeiny, fix vague/Dutch entries)
4d6f0372 CLAUDE.md: translate the full root prompt to English (faithful translation; paths/commands/tables/npubs unchanged)
e70e21dd CLAUDE.md: switch to English + add 'English coaching' rule (act on intent, then a short ✍️ English note)
2c1aa123 CLAUDE.md: add Mission & Purpose at the top (undismissible working demos; learn-by-doing KPI)
0f8010b8 memory: record decision to keep Healthy's RAM alarm sensitive (don't relax it)
e97d209c icons: backfill all 33 goose icons from their DALL-E portraits (retire composite icons)
fd09efcf memory: log decision to park the roster manifest-generator (detection-first via drift-detector)
6f6457c0 goosie help: add Ay block with 'ay drift' (roster drift-check)
b39cd9da icons: add gitea/gitty/humany goose icons (close roster drift-detector gaps)
f13c17be gitignore: de-dupe (drop double strfry/ + redundant lnbits glob; collapse go/pkg+go/bin → go/)
9f4d782f docs: add git-secrets security rules to CLAUDE.md (never commit wallet/nsec keys; pre-commit hook; private origin)
a9d17e3b memory: correct /home/deploy git note (has private GitHub origin; never commit secrets)
c97b2c0d chore: stop tracking go/ GOPATH cache (go/pkg + go/bin) — 27.8k files, regenerable
600c1677 security: stop tracking lnbits-wallet.json (adminkeys) + add pre-commit secret guard
f3fdad6c agents.json: replace 'role to be defined' with real descriptions (welcome, toddy, linky)
59056971 agents.json: backfill welcome + linky npub/pubkey (roster now complete, 0 null npubs)
bfb9f202 docs: drop removed apps from project lists (vformation/swarm/catchzaps/sofia/test/ididhere/mobile/testtrip/rotterdam)
b8d757dd Skeiny: fill in role (Skein availability-weaver) + logo; Splitty new portrait
334d6cf4 splitty: tile quote → 'Splitty will split his donations always over all the goosies'
99caaa70 Splitty: flock sat-distribution hub; Perry wallet back to personal
2efd8323 docs: backup section now includes the Cashu mint ledger
5628f19c todo: Badgy — credential goose for flock-wide badge issuance
c8b962cf docs: sync Healthy interval to reality (4 blocks / ~40 min)
```

## Apps

### gameofthegoose
```
c1c6544 gooseAgents: complete the flock roster — refresh descriptions + add welcome, linky, Splitty, Skeiny
23bb2ed board: repoint removed-app squares — CatchZaps→Welcome, Sofia→Skein
```

### proofofread
```
28ca777 journey redesign — Rungs A & B (give-first, panel fixes)
7a92072 hook: handle the returning user (don't say "earn 11 more" to someone at 21)
2713f2b hook: 60-second magic — 10 sats instant, then earn 11 more (with fogged path)
e37b1f2 onboarding honesty fixes (synthetic-user panel findings)
2e525f9 backup: show nsec alongside the 12 words + explain the difference
65bdd37 start done screen: show the badge + self-hosted verify + Step 3 (keep in wallet)
39abe05 onboarding: friendly, time-aware rate-limit message (no futile retry)
29fa594 ratelimit: env-based IP exempt list (ONBOARD_RATELIMIT_EXEMPT_IPS)
21d5550 start quiz: 5/5 no longer shows "Almost!" (passed lost on resubmit + reward bounce)
82abf57 badge: self-hosted badge page, no third-party viewer
```

### zaphunt
```
9cc8b92 backy: backup status 20260630_030000 [status=ok]
67818bf backy: backup status 20260629_030002 [status=ok]
991d8e2 backy: backup status 20260628_030002 [status=ok]
1bc36db backy: backup status 20260627_030002 [status=ok]
a8d9b8a backy: backup status 20260626_030001 [status=ok]
fa1d7a0 backy: backup status 20260625_030001 [status=ok]
48e7082 backy: backup status 20260624_030001 [status=ok]
```
