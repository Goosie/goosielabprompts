---
name: feedback_home_deploy_git
description: /home/deploy repo heeft geen GitHub remote en dat is bewust zo
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 72481124-22a9-4da7-a483-624adc20fa7b
---

`/home/deploy` is een lokale git repo zonder remote. Nooit een GitHub remote voorstellen of push proberen voor deze repo.

**Why:** Bewuste keuze — dit is lokaal servergeheugen (CLAUDE.md, scripts, configs). Niet alles hoeft op GitHub.

**How to apply:** Bij commits in `/home/deploy`: gewoon lokaal committen, geen push, geen vraag over remote instellen.
