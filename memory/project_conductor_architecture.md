---
name: project_conductor_architecture
description: "Agent architecture — main session = Conductor, CLAUDE.md = Orchestra, the -y goosies are peer subagents; Assistenty is a goosie (synthesis), not the orchestrator"
metadata: 
  node_type: memory
  type: project
  originSessionId: d4a856fb-f003-44ab-b4ec-61649a01b9a9
---

Decided 2026-06-30 with Perry (and taught as an AI-management lesson): separate the two layers cleanly.

- **Conductor** = the main Claude Code session (the orchestrator Perry talks to). A *function role*, not a goose — no `-y` name, no web tile, no Nostr identity. Defined at the top of `.claude/CLAUDE.md` ("## You are the Conductor").
- **Orchestra** = `.claude/CLAUDE.md` itself = the shared context every agent reads (Conductor + all goosie subagents).
- **Goosies** = the flock, names ending in `-y` (Assistenty, Designy, Jurry…). Each has a web tile + Nostr identity (public posts + DMs) + serves as a specialized **subagent** the Conductor dispatches.

**Naming convention:** prompt/orchestration roles → function names (Conductor, Orchestra); flock members → `-y` names (goosies).

**Assistenty** is now a peer goosie — the **synthesis & continuity specialist** (dispatched for status sweeps, tidy-ups, "where were we", briefing new goosies). NOT the orchestrator. The old `.claude/agents/assistenty.md` (default-orchestrator + Sofia/WeddenDat "Formations" + agent-registry + keypair mgmt + placeholder family-recovery) was removed as stale/fake.

**Why:** Perry was confused that "Claude in this prompt" did Assistenty's job — because the main session reading CLAUDE.md literally WAS Assistenty. The unlock (key AI-management concept): an agent = model + context; you don't run an agent, you configure it. See [[feedback_ai_coaching]].

**Open follow-up:** a real family emergency-recovery mechanism belongs in `whenidie.md` with *verified* npubs. The removed placeholder had malformed npubs + names (Rens/Mart/Elly Smit/Blom) that aren't in whenidie.md, and referenced a non-existent FAMILY-RECOVERY.md.
