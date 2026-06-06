---
name: jurry-status
description: "Actuele juridische status van alle Goosie Labs apps — risicoclassificatie, opgeloste bevindingen en openstaande actiepunten per app"
metadata: 
  node_type: memory
  type: project
  originSessionId: 608b3e3f-6196-4cae-b179-3305727be33d
---

Jurry is de juridische agent van Goosie Labs. Script: `node /home/deploy/scripts/jurry/index.js [overview|review <app>|licenses]`
Elk actieve app heeft een `juridischadvies.md` + `juridischadvies.html` (bereikbaar via de landing page tile).

## Risicoclassificatie (laatste run: 2026-05-21)

**🔴 HOOG**
- **weddendat** — Wet op de Kansspelen. P2P-architectuur zonder custody/rake vereist. Juridisch consult aanbevolen vóór launch.
- **lastwill** — Erfrecht/testamentrecht. Disclaimer vereist dat dit geen juridisch testament is. Executor-service ontbreekt nog (acties worden NIET automatisch uitgevoerd).
- **zap-hunt** — Locatiedata + sats-custody model. react-leaflet Hippocratic-2.1 licentie.
- **zaphunt** — AI-hints aansprakelijkheid + sat-deposits nooit custodian.

**🟡 GEMIDDELD**
- **dilemma** — Bounty-escrow nooit via Goosie Labs wallet.
- **zinin** — Zorgplicht fysieke ontmoetingen + 18+.
- **proofofmove** — Camerabeelden client-side houden; blessure-disclaimer.

**🟢 LAAG**
- **ididhere**, **feedback**, **sofia**

## Opgeloste bevindingen

- **zap-hunt** (2026-05-21) — nsec verwijderd uit localStorage. Sleutel opgeslagen als hex bytes onder neutrale sleutelnaam. importeerNsec-optie verwijderd. (commit d15762e)
- **lastwill** (2026-05-21) — secretKeyHex verwijderd uit localStorage, alleen per sessie in memory via relay-decrypt. Action payloads niet meer gecached in localStorage. (commit f3236e8)

## Openstaand voor alle apps

- Privacyverklaring ontbreekt op goosielabs.com
- Algemene voorwaarden ontbreken
- Lightning/Cashu: meldingsplicht DNB bij opschaling
- Nostr-events zijn permanent — gebruikers informeren in UI
- react-leaflet (Hippocratic-2.1) in zap-hunt + sofia — vervangen bij rebuild

## Openstaand per app

**lastwill:**
- Disclaimer in UI: acties worden NIET automatisch uitgevoerd — executor vereist
- Disclaimer: geen juridisch testament
- Grace period uitbreiden: waarschuwingen op 30/10/3 dagen
- Privacy policy

**zap-hunt:**
- Exacte GPS-coördinaten direct na claim-validatie verwijderen uit DB
- IP-adressen niet loggen in rate limiter
- Disclaimer gevaarlijke locaties
- react-leaflet vervangen (Hippocratic-2.1 → MIT)

**weddendat:**
- Architectuurbeslissing vastleggen: geen custody, geen rake
- Disclaimer + 18+ melding in UI
- Juridisch consult iGaming/fintech

**Why:** Perry wil juridische risico's bewust beheren voor launch. Jurry doet periodieke checks.
**How to apply:** Bij bouwen of lanceren van een app, check of de openstaande punten voor die app afgevinkt zijn.
