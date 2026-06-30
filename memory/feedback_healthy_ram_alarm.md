---
name: feedback_healthy_ram_alarm
description: "Leave Healthy's RAM alarm sensitive — never relax it; RAM is the real constraint on this box"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d4a856fb-f003-44ab-b4ec-61649a01b9a9
---

Do NOT relax Healthy's RAM check in `systemsetup/scripts/healthy/checkhealthy.sh` (fail <100MB free, warn <200MB free). Leave it sensitive.

**Why:** RAM (3.8 GB, lots running) is the genuine bottleneck on this droplet, so a low-free-RAM alert is always a real early warning Perry wants loud. On 2026-06-30 the **load** check (1-min → 15-min + per-core) and the **swap** check (now pressure-aware: cold swap = warn, fail only when swap high AND free RAM <400MB) were tuned to stop false alarms — but RAM was deliberately left untouched.

**How to apply:** When tuning Healthy thresholds, adjust load/swap if needed but keep the RAM thresholds as-is. The real fixes for RAM pressure are freeing RAM or a droplet resize, not muting the alarm. See [[feedback_home_deploy_git]].
