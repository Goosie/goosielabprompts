---
name: feedback_home_deploy_git
description: /home/deploy IS pushed to a private GitHub repo — but never commit wallet/identity secrets
metadata:
  node_type: memory
  type: feedback
  originSessionId: 72481124-22a9-4da7-a483-624adc20fa7b
---

`/home/deploy` has a remote `origin → https://github.com/Goosie/home-deploy.git` (PRIVATE) and Perry pushes it. (Earlier note said "no remote, never push" — that is OUTDATED; pushing is fine.) The `gitea` remote on this repo points to a repo that does not exist (`perry/deploy` → "Repository not found") — effectively a dead remote.

**Why:** It's the server's memory (CLAUDE.md, scripts, configs). Fine to back up to a private GitHub repo. The real danger is secrets: on 2026-06-29 it turned out **32 `lnbits-wallet.json` files (LNbits adminkeys + inkeys) were tracked and had been pushed to GitHub**. They were scrubbed from all history with `git filter-repo` and force-pushed clean. Total at risk was ~10k sats (private repo) so keys were NOT rotated.

**How to apply:** Pushing `/home/deploy` to GitHub origin is OK. NEVER commit secrets — `lnbits-wallet.json`, `nostr-key.json`, `bunker.env`, `.env*` are gitignored. A `.git/hooks/pre-commit` hook blocks adding wallet/nsec files or adminkey/nsec values (deletions allowed) — do not bypass with `git add -f`. The wallet files live untracked on disk (services read them). See [[project_wallet_architecture]] and [[feedback_nsec_security]].
