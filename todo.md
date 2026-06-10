# Goosie Labs — Centrale TODO

> Bijgehouden door Astrid. Zeg `@Astrid zet op #todo <taak>` om iets toe te voegen.
> Filter per app: `grep "#app:naam" ~/todo.md`
> Tags: `#server` `#app:<naam>` `#tessa` `#idee` `#finance` `#juridisch` `#urgent`

---

## Open

### General

- [ ] [2026-06-10] `#idee` **Skein — ganzen als dorpsmatchmakers op Nostr** — Mensen met tijd/weinig geld/op zoek naar betekenis roepen een gans aan. Gans bouwt profiel via gesprek, monitort Nostr-signalen (stilte, profielwijzigingen), en keert terug met: "ik ken iemand die jouw bijdrage nu kan gebruiken." Beide kanten opt-in. Ganzen scannen proactief kansen. Verdienmodel: gifeconomie via zaps, bestaande Lightning splitter verdeelt over de formatie. Bouwlaag: DVMCP. Naam: Skein (uitgesproken "skane") — groep ganzen in vlucht én een kluwen dat wordt ontrafeld. MVP: DM-intake + stille wachter.

- [ ] [2026-06-09] `#idee` **Split wallet bij donatie aan Perry** — als iemand naar perry@goosielabs.com doneert, automatisch verdelen over alle ganzen (LNbits split payments). Elke gans krijgt een evenredig deel op z'n eigen Lightning Address.

- [ ] [2026-06-09] `#idee` **Bekijk plaatjes voor ganzen-portretten/brand** — Designy inspiratie van Claude: https://claude.ai/design/p/f5e6e8df-acd0-413d-9875-22329a8de89c?file=components%2Fbrand%2Fportraits.card.html

- [ ] [2026-06-09] `#server` **18 apps: progressive onboarding i.p.v. login wall** — Alle apps hieronder hebben nog `if (!user) return <LoginArea />` als login wall. Vervangen door progressive onboarding: app rendert altijd, write actions gaan via TryItOutModal (al aanwezig in alle apps). Aanpak per app: 1) verwijder `if (!user) return <LoginArea>` blok uit pagina's, 2) zet `<LoginArea>` in de nav header (klein, max-w-40), 3) write actions gaan via `useNostrPublish` (opent TryItOut automatisch) of `useWriteGate().openModal()`. Daarna ook: CSS variabelen gebruiken ipv hardcoded Tailwind kleuren zodat themes werken.
  - [ ] catchzaps — LoginArea in OnboardingPage + Index (2 bestanden)
  - [ ] dilemma — LoginArea in Index
  - [ ] feedback — LoginArea in Index
  - [ ] flocks — LoginArea in Index
  - [ ] gameofthegoose — LoginArea in Index
  - [ ] georgie — LoginArea in 2 bestanden
  - [ ] gooseprogrammer — LoginArea in Index
  - [ ] goosiemanager — LoginArea in Index
  - [ ] honkbadge — LoginArea in Index
  - [ ] honkensus — LoginArea in Index
  - [ ] honkference — LoginArea in Index
  - [ ] honkstation — LoginArea in Index
  - [ ] lastwill — LoginArea in Index
  - [ ] proofofmove — LoginArea in 2 bestanden
  - [ ] sofia — LoginArea in 2 bestanden
  - [ ] swarm — LoginArea + !user pattern in Index
  - [ ] weddendat — LoginArea in Index
  - [ ] zaphunt — `if (!user) return <LoginArea>` login wall in Dashboard.tsx

- [ ] [2026-06-08] `#idee` **Banners voor alle ganzen — scene per gans** — Assistenty als voorbeeld: kantoor met bureau, sticky notes, raam met V-formatie ganzen. Elke gans krijgt een scène die zijn rol vertelt. Handmatig prompts schrijven per gans. Aanpak: `gpt-image-1` + `quality: high` + scene-beschrijving. Script: `/home/deploy/scripts/designy/generate-banners.mjs`, scene-functie in `/tmp/assistenty-scene2.mjs` als template. Achtergrondkleur samplen uit portret.jpg van elke gans.
- [ ] [2026-06-08] `#idee` **Boek LND afmaken** — Lessen toevoegen naarmate het traject vordert. Onderzoek ook hoe bitcoiners onderling nodes in de lucht houden: node-runners gemeenschappen (LightningNetwork+, Amboss, Plebnet, Ring of Fire), peer-to-peer channel agreements, hoe nodes elkaar helpen met liquiditeit en uptime. Voeg toe als les in ~/lessons/lnd.md. Daarna genereer boek LND opnieuw.
- [ ] [2026-06-08] `#server` **LND direct op LNbits aansluiten** — Umbrel LND via Tailscale (100.111.14.11:2101) als funding source voor LNbits. Eerst kanaalmanagement op orde (outbound liquiditeit, SCB backup). Vervangt NWC en maakt donate-betalingen instant. Zie whenidie.md voor LND stack details.
- [ ] [2026-06-08] `#server` **Umbrel kanaalmanagement** — Outbound liquiditeit toevoegen (on-chain storten + kanaal openen of Megalith LSP outbound kopen). Vereiste stap vóór LND→LNbits migratie.
- [ ] [2026-06-08] `#app:bookwriter` **Bookwriter uitbreiden — epub export + cover + Lightning webshop** — 1) Nostr events lezen als materials (zodat Assistenty lessen van relay kan inladen), 2) epub genereren met cover (auteur = Docy), 3) webshop via LNbits module zodat boeken verkocht kunnen worden via Lightning. Zie ~/lessons/lnd.md voor inspiratie.
- [ ] [2026-06-08] `#app:bookwriter` **Bookwriter: Nostr event materials** — Boeken kunnen materiaal importeren van de relay (kind:30023 fragmenten van een specifiek pubkey). Dan kan "Zet lessons learned in book X" van relay direct in Bookwriter verschijnen.
- [ ] [2026-06-08] `#finance` **Send 1500 sats back to Phoenix wallet**
- [ ] [2026-06-08] `#server` **Source code on Git** — Make sure all app repos are pushed and up to date on GitHub. Add links to source code from the homepage tiles or a dedicated page.
- [ ] [2026-06-08] `#idee` **FAQ page on goosielabs.com** — Add a FAQ page answering common questions: what is Nostr, what is Bitcoin/Lightning, what are the geese, how do I get started, is this safe, etc.
- [ ] [2026-06-08] `#idee` **Nostr streams on website** — Embed live Nostr streams on goosielabs.com. Could show a live feed from the relay, or integrate NIP-53 live activities (Honkference sessions, announcements).
- [ ] [2026-06-08] `#server` **Translate homepage to Dutch** — Add a Dutch version of the homepage (or toggle) so Dutch-speaking visitors get content in their language.
- [ ] [2026-06-08] `#server` **Make Cashu Batches working** — Get the Nutshell Cashu mint batch functionality operational on mint.goosielabs.com.

- [ ] [2026-06-07] `#server` **Research LNbits API for QR code** — LNbits may offer a QR code via the API directly. If so, replace the local qrcode-generator library in donate.js with the LNbits API response.

- [ ] [2026-06-07] `#idee` **Users can create their own welfare goose** — A special flow where any user can register a welfare goose (Nostr identity for a good cause). Others can then route a slice of their app payments to it. Extends the goose blockbirth / lastwill system.

- [ ] [2026-06-07] `#server` **Goose blockbirth + profile** — Add `goose-profile.json` per agent with: `blockbirth` (unique block nr ~2009–2015), `interests`, `lifestoflyto`. Display on homepage goose cards: block age (from Blocky via relay), deathblock (blockbirth + 1,576,800). Client-side JS reads current block from relay (kind 30078, d="vformation-lastrun", Blocky pubkey).

- [ ] [2026-06-07] `#idee` **Welfare goosies** — Special Nostr identities for good causes. Apps split a % of their sat income to selected welfare goosies via Lightning/Cashu. Users see which goosies benefit when they pay.

- [ ] [2026-06-06] `#server` `#app:mijnapp` **mijnapp verwijderen** — test app, niet nodig meer. Directory verwijderen + nginx block opruimen.

- [ ] [2026-06-06] `#idee` **Ganzenbord game** — Build a Goosie Labs version of the classic board game Ganzenbord (Game of the Goose), with sats, Nostr and geese.

- [ ] [2026-05-29] `#idee` `#server` **Rename "apps" to "Skein"** — A skein is a group of geese flying together: perfect name for the Goosie Labs app collection. Rename the concept, directory (`/apps/` → `/skein/`), nginx paths, tile references, CLAUDE.md, landing page. Big migration — plan carefully before executing.

- [ ] [2026-05-27] `#server` **Switch everything to English** — all content, writing, thinking, docs, CLAUDE.md files, todo.md, commit messages, and conversations should be in English going forward.

- [ ] [2026-05-27] `#idee` `#server` **Website analytics** — Inzicht in wie er op goosielabs.com en de apps komt. Optie: self-hosted Umami (privacy-first, geen cookies, GDPR). Eventueel een agent die dagelijks Nginx access logs samenvat en rapporteert.

### nsite & Key Management

- [ ] [2026-05-28] `#server` **Manny — manager agent for the Goosie Labs org key** — Create agent Manny who owns and manages the `manager@goosielabs.com` org key. Manny controls nsite publishing, relay whitelist, Blossom config. Keypair already exists (`4735e38a...`). Needs: agents/manny/ directory, manny.md role description, profile picture, kind 0 published.

- [ ] [2026-06-04] `#server` **Remove old Perry pubkey from server configs** — After one week of stable operation with new org key (`4735e38a...`), remove `a80398e86c03ff...` from whitelist.json, blossom/config.yml. Keep it in nostr.json (perry/goosie/zoomer entries) until new personal key is set up.

- [ ] [2026-05-28] `#server` **sync-owner-key script** — Create `scripts/sync-owner-key.mjs` with single source of truth at `/home/deploy/owner.json`. Script updates server.js, whitelist.json, blossom/config.yml and nostr.json in one run, restarts services, then prompts for nsec and republishes the nsite. Three steps becomes one command.

### Server & V-Formatie

- [ ] [2026-05-27] `#server` `#urgent` **Relay whitelist agent + test** — We must control the relay we create and have an agent that maintains the whitelist. Last time we could not send a post. Test this as soon as possible: spin up an agent, verify it can add/remove pubkeys from the whitelist, and confirm posts from whitelisted pubkeys are accepted and others are rejected.

- [ ] [2026-05-27] `#server` **Honky bouwen** — Matchmaker gans. Kijkt naar #iwant en #ihave events op de relay, koppelt vraag en aanbod, stuurt versleutelde intro via NIP-17. Lightning-native: #ihave kan sat-prijs bevatten, #iwant kan budget bevatten. Zie `agents/honky/honky.md`.

### Tessa

- [ ] [2026-05-27] `#tessa` **Playwright skill** — `scripts/tessa/skills/playwright.js` per app. Test volledige UI flow in echte browser (headless Chromium). NIP-07 mocken via `window.nostr` injectie. Begin bij Dilemma: post → advies → upvote → winnaar kiezen.
- [ ] [2026-05-27] `#tessa` **Scheduled agent** — Tessa elke nacht automatisch draaien via cron. Rapportage naar Nostr DM (Perry's npub) of logfile. Zodat Perry 's ochtends weet of apps nog werken.
- [ ] [2026-05-27] `#tessa` **`tessa report` commando** — overzicht van alle apps: welke bereikbaar zijn en wanneer Tessa voor het laatst draaide.

### HelloNsite

- [ ] [2026-05-28] `#app:hellonsite` **Photo attestation / trusted OK sign** — after basic onboarding works: trusted signer (Manny / org key) signs `hash(photo)` as a Nostr event to vouch the photo is legitimate. NIP-58 badge or custom kind. Decide who the trusted signer is (Manny, external, web of trust).

### HonkFerence

- [ ] [2026-05-27] `#app:honkference` **MVP video-stack kiezen** — optie A: WebRTC peer-to-peer (geen server, max ~5 deelnemers); optie B: LiveKit SFU (schaalbaar, externe server); optie C: screenshare embed + Nostr chat/Q&A (simpelst, goed voor eerste versie).
- [ ] [2026-05-27] `#app:honkference` **Rol-gebaseerde layout** — presenter split view (presentatie + deelnemersraster + controls), deelnemer theater view (grote video, controls als overlay). Rol bepalen via NIP-30311 host-pubkey.
- [ ] [2026-05-27] `#app:honkference` **Fullscreen voor deelnemers** — `videoElement.requestFullscreen()` op video-container (niet `document`), zodat chat/sidebar buiten fullscreen zichtbaar blijft.
- [ ] [2026-05-27] `#app:honkference` **Routes splitsen** — `/present` voor presentator, `/watch/:eventId` voor deelnemers.

### Feedback

- [ ] [2026-05-27] `#app:feedback` **Escrow v2** — echte Cashu uitbetaling via `POST /api/feedback/submit` op de server (nu mock).
- [ ] [2026-05-27] `#app:feedback` **NIP-44 migratie** — v1 gebruikt NIP-04 voor brede compatibiliteit, v2 naar ChaCha20.
- [ ] [2026-05-27] `#app:feedback` **Ephemeral keypair** — optie in `/f/:id` om volledig anoniem in te vullen zonder Nostr login.
- [ ] [2026-05-27] `#app:feedback` **Escrow storting UI** — Lightning invoice tonen in `/request/new` voor daadwerkelijke storting.
- [ ] [2026-05-27] `#app:feedback` **max_responses enforcement** — server-side check dat escrow niet wordt leeggetrokken.
- [ ] [2026-05-27] `#app:feedback` **FeedbackButton integreren** — toevoegen aan ZapHunt, IDidHere, Sofia, Routstr tiles.

### ZapHunt

- [ ] [2026-05-27] `#app:zaphunt` **LNbits treasury wallet** — aanmaken en ID opslaan in `.env`.
- [ ] [2026-05-27] `#app:zaphunt` **LNbits admin key** — ophalen en in `.env` zetten.
- [ ] [2026-05-27] `#app:zaphunt` **Backend server** — Express + SQLite opzetten.
- [ ] [2026-05-27] `#app:zaphunt` **Hunt aanmaken flow** — bouwen.
- [ ] [2026-05-27] `#app:zaphunt` **LNbits sub-wallet API integratie**.
- [ ] [2026-05-27] `#app:zaphunt` **AI vraag-generatie** — Claude API integratie.
- [ ] [2026-05-27] `#app:zaphunt` **GPS-check middleware**.
- [ ] [2026-05-27] `#app:zaphunt` **Cashu payout flow**.
- [ ] [2026-05-27] `#app:zaphunt` **Frontend** — hunt-overzicht, aanmaken, spelen.
- [ ] [2026-05-27] `#app:zaphunt` **systemd service** — voor backend.

---

## Gedaan

- [x] [2026-05-26] `#server` **Routstr 403** — `/apps` en `/apps/` redirecten nu via nginx naar `/#apps`.
- [x] [2026-05-21] `#tessa` **Tessa uitgerold** — seed.js per app aanwezig met app-specifieke event kinds.
- [ ] [2026-06-05] `#testy` Test: DM sturen naar Backy vanaf mobiel (bijv. Amethyst) met 'snapshot' → controleert of Backy reageert en DO snapshot aanmaakt
- [ ] [2026-06-05] `#testy` Test /help naar Backy sturen vanuit Amethyst (mobiel) → controleer of Backy reageert en of de communicatie zichtbaar is in Swarm dashboard

- [ ] [2026-06-06] `#idee` `#server` **Auth-patronen voor newapp** — Standaardiseer login-keuzes bij nieuwe app-aanmaak. Patronen: A=gast verborgen, B=gast+banner, C=gast+Nostr-keuze, D=progressive disclosure (MKStack standaard), E=login wall, F=anoniem+optioneel, G=Nostr vereist, H=bunker-only. Toevoegen aan: newapp-web formulier (keuze-selector), newapp CLI (vraag bij aanmaak), CLAUDE.md (documentatie per patroon + welke componenten horen erbij), boilerplate-varianten. Eerst documenteren in CLAUDE.md, dan implementeren.
