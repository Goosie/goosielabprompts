# Goosie Labs — Centrale TODO

> Bijgehouden door Astrid. Zeg `@Astrid zet op #todo <taak>` om iets toe te voegen.
> Filter per app: `grep "#app:naam" ~/todo.md`
> Tags: `#server` `#app:<naam>` `#tessa` `#idee` `#finance` `#juridisch` `#urgent`

---

## Open

### General

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
