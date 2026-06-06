---
name: feedback-commit-strategy
description: "Perry wil dat ongerelateerd uncommitted werk in een eigen commit gaat, niet meegebundeld"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 07f89932-2ed0-4ef5-8104-a3d195e60cca
---

Als ik tijdens werk uncommitted wijzigingen van een vorige sessie tegenkom die thematisch lijken op de huidige taak, moet ik die NIET stilzwijgend mee-committen. Vraag eerst, en standaard: aparte commits per logische eenheid.

**Why:** Perry koos expliciet voor "Eerst bestaande, dan nieuwe" toen ik vroeg hoe ik openapp/newapp tmux-aanpassingen (al uncommitted in .bashrc) moest combineren met mijn nieuwe startmytmux/gans-functies. Hij wil duidelijke geschiedenisstappen — niet één grote commit waarin het werk van verschillende sessies verstrengeld zit.

**How to apply:** Bij `git status` aan het begin: scan de M-status bestanden vs HEAD. Als er al wijzigingen waren vóór mijn werk én ik ga datzelfde bestand óók wijzigen, vraag actief welke commit-strategie hij wil. Default-vermoeden: aparte commits in chronologische volgorde van het werk.
