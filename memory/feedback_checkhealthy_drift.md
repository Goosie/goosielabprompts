---
name: feedback-checkhealthy-drift
description: "Healthy/checkhealthy — live vs repo drift lesson + current state (symlink, RAM-aware swap, 12h DM throttle, weekly session-cleanup)"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: cf67e711-d848-4989-94f3-c8bf1a5861c5
---

When a Healthy/monitoring fix "doesn't take" (Perry keeps getting alarms after you fixed it), suspect **live-vs-repo drift before re-patching**. On 2026-07-07 an improved `checkhealthy` was already committed in the repo but the running copy at `/usr/local/bin/checkhealthy` was a stale *copy* that was never redeployed — so the fix existed in git but not live.

**Why:** "committed in git" ≠ "running live". Files run either directly from the repo (via the `scripts/` symlink → `systemsetup/`, edit = instantly live) or as a separate deployed copy on a system path (needs a manual copy step, can silently drift).

**How to apply:**
- Before hand-patching a deployed system file, check for a source-controlled version: `find /home/deploy/systemsetup -name '<file>*'` and `diff` it against the live one. The repo copy may already be newer/better.
- `checkhealthy` is now a **symlink** `/usr/local/bin/checkhealthy → systemsetup/scripts/healthy/checkhealthy.sh` — edit the repo file, it's live, no deploy. Do NOT replace it with a copy (reintroduces the gap). Header comment in the file says so.

Current Healthy state (all in the `systemsetup` repo, pushed to Gitea):
- **Swap alarm is RAM-aware**: swap>80% is only 🔴 when free RAM is also low (<400MB); otherwise 🟡 ("cold" swap on a healthy box is normal, not a crisis). Stops the 🟡↔🔴 flapping at the threshold.
- **Load** uses the 15-minute figure (not 1-min) so transient build spikes don't trip it.
- **DM throttle**: 🔴 DM only on status *change* to red, then at most once per 12h while it stays red (`DM_REMINDER_MS` in `scripts/healthy/index.mjs`). No more hourly spam.
- **Weekly session-cleanup** (Blocky, 1008 blocks, signs as Devy): `scripts/session-cleanup/index.mjs` closes tmux sessions that are detached AND idle >7d — the abandoned Claude sessions whose swapped pages kept refilling swap. Recoverable via `claude --resume`.

Root cause of the recurring swap alarm was accumulated idle/detached tmux Claude sessions swapping out over long uptime — not a leak. See [[user-perry]].
