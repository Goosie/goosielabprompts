---
name: feedback-lean-deps-architecture
description: "Voor apps/boilerplate: dunne zelf-bezeten laag boven zware externe dependencies; provider-agnostisch; koekjesvorm licht houden"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 25883bd4-1f8f-44d9-970e-e63a437a3441
---

Bij de vraag "hoe integreren we externe code/diensten in de boilerplate of een app", kies standaard voor een **dunne, zelfgeschreven laag die Perry zelf bezit en begrijpt**, boven een zware externe dependency. Houd de boilerplate-template ("koekjesvorm") licht: features die niet elke app nodig heeft, moeten opt-in en tree-shake-baar zijn (pure code, geen npm-dependency die overal meekomt). Maak integraties waar mogelijk **provider-agnostisch** (bv. OpenAI-compatibel i.p.v. vastzitten aan één leverancier).

**Why:** Perry bouwt snel professionele Nostr-apps "zonder rompslomp en niet te afhankelijk van anderen". Concreet bevestigd toen ik als "architect-gans" route B koos boven `@routstr/sdk`: de SDK was pre-1.0 en sleepte Cashu/wallet/discovery mee die hij niet wilde. De ~60-regel `useAI`-client tegen een OpenAI-compatibele endpoint won, juist omdat hij 'm bezit, snapt, en nergens aan vastzit. Dit sluit aan op zijn wereldbeeld (Austrian economics, zelfsoevereiniteit/SSI — zie [[user-perry]]).

**How to apply:** Bij "zullen we dependency X / SDK Y toevoegen?" → weeg gewicht, maturity (pre-1.0 = breekrisico) en lock-in. Geef een decisieve, beargumenteerde aanbeveling en push gerust terug op een eerdere keuze van Perry als die niet past (hij waardeert tegenargumenten). Voorkeur: thin self-owned layer, opt-in, provider-agnostisch. Tegenvoorbeeld om te vermijden: een zware SDK standaard in elke app bakken.
