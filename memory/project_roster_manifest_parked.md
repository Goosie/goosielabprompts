---
name: project_roster_manifest_parked
description: "Decision — roster \"single-manifest generator\" is parked; detection-first via the drift-detector until drift proves recurring"
metadata: 
  node_type: memory
  type: project
  originSessionId: d4a856fb-f003-44ab-b4ec-61649a01b9a9
---

The goose roster lives in ~10 files (nostr-key.json, agents.json, .claude/agents/*.md, agents/<n>/<n>.md, whitelist.json, .well-known/nostr.json, generate-agent-icons.mjs, generate-agent-portraits.mjs, publish-homepage AGENT_COLORS, gameofthegoose gooseAgents.ts). On 2026-06-29 these had drifted and were hand-synced.

**Decision (Perry + Thinky, 2026-06-29):** the manual sync was mostly one-off **backlog**, not recurring pain. So we build **detection, not generation**:
- ✅ Built `systemsetup/scripts/check-roster-drift.mjs`, wired into Ay (`ay drift`, and `ay check` which is Blocky-scheduled) + humany `newgoose`. See [[project_wallet_architecture]].
- ⏸️ A "single goose-manifest (`agents/<n>/goose.json`) → generator regenerates all derived files" is **parked**. Do NOT build it until the drift-detector flags recurring drift over weeks (then we'll also know exactly which files it must generate).

Thinky's reasons to wait: (1) no evidence yet the drift recurs — the detector just went green; (2) cross-repo generation (gooseAgents.ts in the gameofthegoose repo) needs a publish step that already tripped humany; (3) a generator nobody runs / that gets hand-edited rots next to the existing broken `sync-agents` alias. Revisit only on evidence.
