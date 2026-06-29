---
name: feedback_home_deploy_git
description: /home/deploy IS pushed to a private GitHub repo — but never commit wallet/identity secrets
metadata:
  node_type: memory
  type: feedback
  originSessionId: 72481124-22a9-4da7-a483-624adc20fa7b
---

`/home/deploy` has a remote `origin → https://github.com/Goosie/home-deploy.git` (PRIVATE) and Perry pushes it. (An earlier note said "no remote, never push" — that is OUTDATED; pushing is fine.) There is no working `gitea` remote for this repo (the `perry/deploy` repo does not exist on Gitea) — the dead remote was removed 2026-06-29.

**Why:** It's the server's memory (CLAUDE.md, scripts, configs) and fine to back up to a private GitHub repo. The real danger is secrets: on 2026-06-29 it turned out **32 `lnbits-wallet.json` files (LNbits adminkeys + inkeys) were tracked and had been pushed**. They were scrubbed from all history with `git filter-repo` + force-push. The Go GOPATH cache (`go/pkg`, `go/bin`, ~27.8k files) was also scrubbed from history the same day to shrink the repo. Total sat-risk was ~10k (private repo) so LNbits keys were NOT rotated.

**How to apply:** Pushing `/home/deploy` to GitHub `origin` is OK. NEVER commit secrets — `lnbits-wallet.json`, `nostr-key.json`, `bunker.env`, `.env*`, `go/pkg/`, `go/bin/` are gitignored. A `.git/hooks/pre-commit` hook blocks adding wallet/nsec files or adminkey/nsec values (deletions allowed) — do not bypass with `git add -f`. ⚠️ `git filter-repo` does a `reset --hard` that discards UNCOMMITTED tracked changes — commit work before running it. See [[project_wallet_architecture]] and [[feedback_nsec_security]].
