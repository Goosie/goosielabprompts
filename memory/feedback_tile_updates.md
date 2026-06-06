---
name: feedback-tile-updates
description: Bij tile-omschrijvingen altijd ook CLAUDE.md updaten en committen
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c50e35a0-64bc-42c8-8370-6549e1415c95
---

Bij elke wijziging van een tile.json omschrijving altijd ook:
1. De globale CLAUDE.md (~/.claude/CLAUDE.md) updaten
2. De project CLAUDE.md (/home/deploy/CLAUDE.md) updaten
3. Alles committen in de relevante repos

**Why:** Perry zei "uiteraard, altijd doen" — dit is een standaard workflow, niet een losse actie.

**How to apply:** Niet vragen of het moet, gewoon direct doen. Tile update = CLAUDE.md update + commit.
