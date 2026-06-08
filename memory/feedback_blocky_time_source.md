---
name: feedback_blocky_time_source
description: "Blocky is the V-Formation clock — all recurring goose tasks belong in Blocky's schedule, never in cron"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ab00f9db-6f59-44f8-a3b4-cd68855945c5
---

Blocky is the timer. Never use cron for recurring goose tasks — they belong in Blocky's schedule.

**Why:** Blocky uses Bitcoin block height as a decentralized clock (~10 min per block). All V-Formation scheduling is centralized there, visible and auditable on the relay. Perry confirmed this explicitly when building Healthy.

**How to apply:**
- When Perry asks to run something periodically → add it to `DEFAULT_SCHEDULE` in `scripts/blocky/index.mjs`, run `clean-relay`, restart blocky
- Never suggest `crontab` for goose scheduling
- Use `goosie blocky schedule` to show the current overview
- The only exception: a cron as silent fallback for a critical health monitor that must run even when Blocky itself is down (Healthy has this pattern)

**Current schedule (2026-06-08):**
| Goose   | Interval     | Approx   |
|---------|-------------|----------|
| testy   | 144 blocks  | ~1 day   |
| secury  | 1008 blocks | ~1 week  |
| jurry   | 4032 blocks | ~4 weeks |
| ay      | 2016 blocks | ~2 weeks |
| backy   | 1000 blocks | ~1 week  |
| healthy | 3 blocks    | ~30 min  |

**Block height:** read from relay (kind 30078, d="vformation-lastrun", author=Blocky pubkey `d4e2e205...`). For server-side scripts: local Umbrel node `http://100.111.14.11:3006/api/blocks/tip/height` first, mempool.space as fallback.
