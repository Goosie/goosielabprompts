# Goosie Labs — Central TODO

> Managed by the Conductor. Say `put on #todo <task>` to add an item.
> Filter per app: `grep "#app:<name>" ~/todo.md`
> Tags: `#server` `#app:<name>` `#testy` `#idea` `#finance` `#legal` `#urgent`

---

## Open

- [ ] [2026-07-01] `#app:start` `#app:bookwriter` `#app:proofofread` `#idea` **3-stage onboarding → reading-proof roadmap** — Mission bar (CLAUDE.md): *undismissible = one real person who isn't Perry comes back a second time.* Architecture (Thinky-gated): **ProofOfRead = pure verifier · Bookwriter = author · joined by a Nostr book event (kind 30023).** The apps compose, they don't merge; content lives on Nostr, not hardcoded.
  - **Stage 1 — "Start here" (onboarding front door).** A stranger walks away with a Nostr identity + Lightning wallet + 21 sats, easily, then discovers the other apps.
    - [x] Tested `/start` with AI personas (pass + fail) against the live API — money logic solid + idempotent (no double-pay).
    - [x] Fixed the badge pass-gate bug — badge + certificate were issued even on a fail; now gated on a pass for *every* book (Honk = all 3, core books = 60%).
    - [x] "Start here" tile live, first on the board (`order:0` → start.goosielabs.com).
    - [ ] **Real friend test** — the one signal AI personas can't give: does a human find it obvious? (This is the mission bar.)
    - [x] Custom "Start here" icon — AERIAL archway diorama (matches Mint/ProofOfMove).
    - [ ] Later: extract into a standalone `/apps/start` app **only if the tile earns it** (don't scaffold prematurely).
  - **Stage 2 — Bookwriter as second tile.** Write book #2, publish to Nostr (kind 30023). Add the Bookwriter tile. Add a "create a reading proof" handoff after publish (registers the book's naddr with ProofOfRead).
  - **Stage 3 — ProofOfRead consumes a Nostr book.** Given a book naddr: fetch chapters, render as reading content, generate the quiz **from the real text** (fixes today's metadata-only quiz), issue badge. Remove hardcoded `HonkStandardContent`. Open decisions: (a) quiz source — hand-written for onboarding vs AI for library books; (b) approved-books trust registry (who is badge-worthy). Payoff: retention becomes measurable — one npub with 2+ books/badges = a returning reader.

- [ ] [2026-07-01] `#server` **Gitea mirror broken fleet-wide — stale `GITEA_TOKEN`** — `GITEA_TOKEN` in `~/.env.services` returns 401 (stale); the working token (`~/.goosie.env`) only has `write:repository` scope, not `write:user`, so repo *creation* via the Gitea API fails → `scripts/gitty/mirror.mjs` can't auto-create mirrors. GitHub pushes are all fine; only the git.goosielabs.com **mirror** is down. Fix: refresh `GITEA_TOKEN` with `write:user` scope (or create repos manually in the Gitea UI, then `git push gitea main`). Surfaced 2026-07-01 during the NosterIn git baseline — `perry/nosterin` mirror still needs creating.

- [x] [2026-06-30] `#server` **Review nosty.md body** — its prompt describes a *fabricated* AWS-signing architecture ("…uses AWS to sign events / coordinates signing"). Rewrite to the real key model: per-goosie `nostr-key.json`, `sync-configs` (derived files), `rotatekey` (rotation), `bunker.env`. Part of the per-goosie prompt-body review.
- [ ] [2026-06-26] `#idea` `#app:proofofread` **Badgy — credential-gans** — Maak een eigen gans die NIP-58 badges uitreikt voor de hele formatie (ProofOfRead, ididhere, toekomstige apps), i.p.v. een anonieme app-key. Tijdelijke fix nu: `proofofread_badge_issuer` (bb540ab1…) staat in `WHITELIST_PERMANENT` in `sync-configs`. Bij bouw van Badgy: die regel verwijderen en ProofOfRead laten signen met Badgy's sleutel. **Ontwerpkeuze eerst via Thinky:** Badgy als losse identiteit (nsec verspreidt over alle apps — sleutel-proliferatie) vs. Badgy als signing-service (apps vragen een badge aan, Badgy tekent centraal — schoner maar meer werk).
- [ ] [2026-06-16] `#app:skein` NIP-17 upgrade — booking + callback berichten als gift-wrapped DM (kind 14 in kind 1059) i.p.v. publiek `kind:1`. Nu lekt elk slot/contact via de relay. Vereist nostrify NIP-44/NIP-59 helpers in de visitor flow.

### General

1. [ ] [2026-06-10] `#idea` **Skein — ganzen als dorpsmatchmakers op Nostr** — Mensen met tijd/weinig geld/op zoek naar betekenis roepen een gans aan. Gans bouwt profiel via gesprek, monitort Nostr-signalen (stilte, profielwijzigingen), en keert terug met: "ik ken iemand die jouw bijdrage nu kan gebruiken." Beide kanten opt-in. Ganzen scannen proactief kansen. Verdienmodel: gifeconomie via zaps, bestaande Lightning splitter verdeelt over de formatie. Bouwlaag: DVMCP. Naam: Skein (uitgesproken "skane") — groep ganzen in vlucht én een kluwen dat wordt ontrafeld. MVP: DM-intake + stille wachter.

2. [x] [2026-06-09] `#idea` **Split wallet bij donatie aan Perry** — als iemand naar perry@goosielabs.com doneert, automatisch verdelen over alle ganzen (LNbits split payments). Elke gans krijgt een evenredig deel op z'n eigen Lightning Address.

3. [ ] [2026-06-09] `#idea` **Bekijk plaatjes voor ganzen-portretten/brand** — Designy inspiratie van Claude: https://claude.ai/design/p/f5e6e8df-acd0-413d-9875-22329a8de89c?file=components%2Fbrand%2Fportraits.card.html

4. [ ] [2026-06-09] `#server` **18 apps: progressive onboarding i.p.v. login wall** — Alle apps hieronder hebben nog `if (!user) return <LoginArea />` als login wall. Vervangen door progressive onboarding: app rendert altijd, write actions gaan via TryItOutModal (al aanwezig in alle apps). Aanpak per app: 1) verwijder `if (!user) return <LoginArea>` blok uit pagina's, 2) zet `<LoginArea>` in de nav header (klein, max-w-40), 3) write actions gaan via `useNostrPublish` (opent TryItOut automatisch) of `useWriteGate().openModal()`. Daarna ook: CSS variabelen gebruiken ipv hardcoded Tailwind kleuren zodat themes werken.
   - 4b. [ ] dilemma — LoginArea in Index
   - 4c. [ ] feedback — LoginArea in Index
   - 4e. [ ] gameofthegoose — LoginArea in Index
   - 4f. [ ] georgie — LoginArea in 2 bestanden
   - 4i. [ ] honkbadge — LoginArea in Index
   - 4j. [ ] honkensus — LoginArea in Index
   - 4k. [ ] honkference — LoginArea in Index
   - 4l. [ ] honkstation — LoginArea in Index
   - 4m. [ ] lastwill — LoginArea in Index
   - 4n. [ ] proofofmove — LoginArea in 2 bestanden
   - 4r. [ ] zaphunt — `if (!user) return <LoginArea>` login wall in Dashboard.tsx

5. [ ] [2026-06-08] `#idea` **Banners voor alle ganzen — scene per gans** — Assistenty als voorbeeld: kantoor met bureau, sticky notes, raam met V-formatie ganzen. Elke gans krijgt een scène die zijn rol vertelt. Handmatig prompts schrijven per gans. Aanpak: `gpt-image-1` + `quality: high` + scene-beschrijving. Script: `/home/deploy/scripts/designy/generate-banners.mjs`, scene-functie in `/tmp/assistenty-scene2.mjs` als template. Achtergrondkleur samplen uit portret.jpg van elke gans.

6. [ ] [2026-06-08] `#idea` **Boek LND afmaken** — Lessen toevoegen naarmate het traject vordert. Onderzoek ook hoe bitcoiners onderling nodes in de lucht houden: node-runners gemeenschappen (LightningNetwork+, Amboss, Plebnet, Ring of Fire), peer-to-peer channel agreements, hoe nodes elkaar helpen met liquiditeit en uptime. Voeg toe als les in ~/lessons/lnd.md. Daarna genereer boek LND opnieuw.

7. [x] [2026-06-08] `#server` **LND direct op LNbits aansluiten** — Umbrel LND via Tailscale (100.111.14.11:2101) als funding source voor LNbits. Eerst kanaalmanagement op orde (outbound liquiditeit, SCB backup). Vervangt NWC en maakt donate-betalingen instant. Zie whenidie.md voor LND stack details.

8. [x] [2026-06-08] `#server` **Umbrel kanaalmanagement** — Outbound liquiditeit toevoegen (on-chain storten + kanaal openen of Megalith LSP outbound kopen). Vereiste stap vóór LND→LNbits migratie.

9. [ ] [2026-06-08] `#app:bookwriter` **Bookwriter uitbreiden — epub export + cover + Lightning webshop** — 1) Nostr events lezen als materials (zodat Assistenty lessen van relay kan inladen), 2) epub genereren met cover (auteur = Docy), 3) webshop via LNbits module zodat boeken verkocht kunnen worden via Lightning. Zie ~/lessons/lnd.md voor inspiratie.

10. [ ] [2026-06-08] `#app:bookwriter` **Bookwriter: Nostr event materials** — Boeken kunnen materiaal importeren van de relay (kind:30023 fragmenten van een specifiek pubkey). Dan kan "Zet lessons learned in book X" van relay direct in Bookwriter verschijnen.

11. [ ] [2026-06-08] `#finance` **Send 1500 sats back to Phoenix wallet**

12. [ ] [2026-06-08] `#server` **Source code on Git** — Make sure all app repos are pushed and up to date on GitHub. Add links to source code from the homepage tiles or a dedicated page.

13. [ ] [2026-06-08] `#idea` **FAQ page on goosielabs.com** — Add a FAQ page answering common questions: what is Nostr, what is Bitcoin/Lightning, what are the geese, how do I get started, is this safe, etc.

14. [ ] [2026-06-08] `#idea` **Nostr streams on website** — Embed live Nostr streams on goosielabs.com. Could show a live feed from the relay, or integrate NIP-53 live activities (Honkference sessions, announcements).

15. [ ] [2026-06-08] `#server` **Translate homepage to Dutch** — Add a Dutch version of the homepage (or toggle) so Dutch-speaking visitors get content in their language.

16. [ ] [2026-06-08] `#server` **Make Cashu Batches working** — Get the Nutshell Cashu mint batch functionality operational on mint.goosielabs.com.

17. [ ] [2026-06-07] `#server` **Research LNbits API for QR code** — LNbits may offer a QR code via the API directly. If so, replace the local qrcode-generator library in donate.js with the LNbits API response.

18. [ ] [2026-06-07] `#idea` **Users can create their own welfare goose** — A special flow where any user can register a welfare goose (Nostr identity for a good cause). Others can then route a slice of their app payments to it. Extends the goose blockbirth / lastwill system.

19. [ ] [2026-06-07] `#server` **Goose blockbirth + profile** — Add `goose-profile.json` per agent with: `blockbirth` (unique block nr ~2009–2015), `interests`, `lifestoflyto`. Display on homepage goose cards: block age (from Blocky via relay), deathblock (blockbirth + 1,576,800). Client-side JS reads current block from relay (kind 30078, d="vformation-lastrun", Blocky pubkey).

20. [ ] [2026-06-07] `#idea` **Welfare goosies** — Special Nostr identities for good causes. Apps split a % of their sat income to selected welfare goosies via Lightning/Cashu. Users see which goosies benefit when they pay.

21. [ ] [2026-06-06] `#server` `#app:mijnapp` **mijnapp verwijderen** — test app, niet nodig meer. Directory verwijderen + nginx block opruimen.

22. [ ] [2026-06-06] `#idea` **Ganzenbord game** — Build a Goosie Labs version of the classic board game Ganzenbord (Game of the Goose), with sats, Nostr and geese.

23. [ ] [2026-05-29] `#idea` `#server` **Rename "apps" to "Skein"** — A skein is a group of geese flying together: perfect name for the Goosie Labs app collection. Rename the concept, directory (`/apps/` → `/skein/`), nginx paths, tile references, CLAUDE.md, landing page. Big migration — plan carefully before executing.

24. [ ] [2026-05-27] `#server` **Switch everything to English** — all content, writing, thinking, docs, CLAUDE.md files, todo.md, commit messages, and conversations should be in English going forward.

25. [ ] [2026-05-27] `#idea` `#server` **Website analytics** — Inzicht in wie er op goosielabs.com en de apps komt. Optie: self-hosted Umami (privacy-first, geen cookies, GDPR). Eventueel een agent die dagelijks Nginx access logs samenvat en rapporteert.

### nsite & Key Management

26. [x] [2026-05-28] `#server` **Manny — manager agent for the Goosie Labs org key** — Create agent Manny who owns and manages the `manager@goosielabs.com` org key. Manny controls nsite publishing, relay whitelist, Blossom config. Keypair already exists (`4735e38a...`). Needs: agents/manny/ directory, manny.md role description, profile picture, kind 0 published.

27. [ ] [2026-06-04] `#server` **Remove old Perry pubkey from server configs** — After one week of stable operation with new org key (`4735e38a...`), remove `a80398e86c03ff...` from whitelist.json, blossom/config.yml. Keep it in nostr.json (perry/goosie/zoomer entries) until new personal key is set up.

28. [ ] [2026-05-28] `#server` **sync-owner-key script** — Create `scripts/sync-owner-key.mjs` with single source of truth at `/home/deploy/owner.json`. Script updates server.js, whitelist.json, blossom/config.yml and nostr.json in one run, restarts services, then prompts for nsec and republishes the nsite. Three steps becomes one command.

### Server & V-Formatie

29. [x] [2026-05-27] `#server` `#urgent` **Relay whitelist agent + test** — ✅ **CLOSED 2026-07-01:** whitelist agent = admission DVM (fixed the `loadWhitelist(...).includes` object-vs-array crash, `admitty@6a81d4b`); `policy.js` accepts whitelisted pubkeys + rejects randoms + leaves open app-kinds free (piped-event acceptance test passed); the "can't post" bug was already fixed by the 06-29 `policy.js` object-format update (live + committed); and `sync-configs` now preserves `admitted_*` users across regen (tested: survives a rebuild). _Original ask:_ We must control the relay we create and have an agent that maintains the whitelist. Last time we could not send a post. Test this as soon as possible: spin up an agent, verify it can add/remove pubkeys from the whitelist, and confirm posts from whitelisted pubkeys are accepted and others are rejected.

30. [ ] [2026-05-27] `#server` **Honky bouwen** — Matchmaker gans. Kijkt naar #iwant en #ihave events op de relay, koppelt vraag en aanbod, stuurt versleutelde intro via NIP-17. Lightning-native: #ihave kan sat-prijs bevatten, #iwant kan budget bevatten. Zie `agents/honky/honky.md`.

### Testy

31. [ ] [2026-05-27] `#testy` **Playwright skill** — `scripts/tessa/skills/playwright.js` per app. Test volledige UI flow in echte browser (headless Chromium). NIP-07 mocken via `window.nostr` injectie. Begin bij Dilemma: post → advies → upvote → winnaar kiezen.

32. [ ] [2026-05-27] `#testy` **Scheduled agent** — Tessa elke nacht automatisch draaien via cron. Rapportage naar Nostr DM (Perry's npub) of logfile. Zodat Perry 's ochtends weet of apps nog werken.

33. [ ] [2026-05-27] `#testy` **`tessa report` commando** — overzicht van alle apps: welke bereikbaar zijn en wanneer Tessa voor het laatst draaide.

### HelloNsite

34. [ ] [2026-05-28] `#app:hellonsite` **Photo attestation / trusted OK sign** — after basic onboarding works: trusted signer (Manny / org key) signs `hash(photo)` as a Nostr event to vouch the photo is legitimate. NIP-58 badge or custom kind. Decide who the trusted signer is (Manny, external, web of trust).

### HonkFerence

35. [ ] [2026-05-27] `#app:honkference` **MVP video-stack kiezen** — optie A: WebRTC peer-to-peer (geen server, max ~5 deelnemers); optie B: LiveKit SFU (schaalbaar, externe server); optie C: screenshare embed + Nostr chat/Q&A (simpelst, goed voor eerste versie).

36. [ ] [2026-05-27] `#app:honkference` **Rol-gebaseerde layout** — presenter split view (presentatie + deelnemersraster + controls), deelnemer theater view (grote video, controls als overlay). Rol bepalen via NIP-30311 host-pubkey.

37. [ ] [2026-05-27] `#app:honkference` **Fullscreen voor deelnemers** — `videoElement.requestFullscreen()` op video-container (niet `document`), zodat chat/sidebar buiten fullscreen zichtbaar blijft.

38. [ ] [2026-05-27] `#app:honkference` **Routes splitsen** — `/present` voor presentator, `/watch/:eventId` voor deelnemers.

### Feedback

39. [ ] [2026-05-27] `#app:feedback` **Escrow v2** — echte Cashu uitbetaling via `POST /api/feedback/submit` op de server (nu mock).

40. [ ] [2026-05-27] `#app:feedback` **NIP-44 migratie** — v1 gebruikt NIP-04 voor brede compatibiliteit, v2 naar ChaCha20.

41. [ ] [2026-05-27] `#app:feedback` **Ephemeral keypair** — optie in `/f/:id` om volledig anoniem in te vullen zonder Nostr login.

42. [ ] [2026-05-27] `#app:feedback` **Escrow storting UI** — Lightning invoice tonen in `/request/new` voor daadwerkelijke storting.

43. [ ] [2026-05-27] `#app:feedback` **max_responses enforcement** — server-side check dat escrow niet wordt leeggetrokken.

44. [ ] [2026-05-27] `#app:feedback` **FeedbackButton integreren** — toevoegen aan ZapHunt, IDidHere, Sofia, Routstr tiles.

### ZapHunt

45. [ ] [2026-05-27] `#app:zaphunt` **LNbits treasury wallet** — aanmaken en ID opslaan in `.env`.

46. [ ] [2026-05-27] `#app:zaphunt` **LNbits admin key** — ophalen en in `.env` zetten.

47. [ ] [2026-05-27] `#app:zaphunt` **Backend server** — Express + SQLite opzetten.

48. [ ] [2026-05-27] `#app:zaphunt` **Hunt aanmaken flow** — bouwen.

49. [ ] [2026-05-27] `#app:zaphunt` **LNbits sub-wallet API integratie**.

50. [ ] [2026-05-27] `#app:zaphunt` **AI vraag-generatie** — Claude API integratie.

51. [ ] [2026-05-27] `#app:zaphunt` **GPS-check middleware**.

52. [ ] [2026-05-27] `#app:zaphunt` **Cashu payout flow**.

53. [ ] [2026-05-27] `#app:zaphunt` **Frontend** — hunt-overzicht, aanmaken, spelen.

54. [ ] [2026-05-27] `#app:zaphunt` **systemd service** — voor backend.

---

## Gedaan

- [x] [2026-05-26] `#server` **Routstr 403** — `/apps` en `/apps/` redirecten nu via nginx naar `/#apps`.
- [x] [2026-05-21] `#testy` **Tessa uitgerold** — seed.js per app aanwezig met app-specifieke event kinds.

### Testy Items (to be categorized)

55. [ ] [2026-06-05] `#testy` Test: DM sturen naar Backy vanaf mobiel (bijv. Amethyst) met 'snapshot' → controleert of Backy reageert en DO snapshot aanmaakt

56. [ ] [2026-06-05] `#testy` Test /help naar Backy sturen vanuit Amethyst (mobiel) → controleer of Backy reageert en of de communicatie zichtbaar is in Swarm dashboard

### Auth Patterns

57. [ ] [2026-06-06] `#idea` `#server` **Auth-patronen voor newapp** — Standaardiseer login-keuzes bij nieuwe app-aanmaak. Patronen: A=gast verborgen, B=gast+banner, C=gast+Nostr-keuze, D=progressive disclosure (MKStack standaard), E=login wall, F=anoniem+optioneel, G=Nostr vereist, H=bunker-only. Toevoegen aan: newapp-web formulier (keuze-selector), newapp CLI (vraag bij aanmaak), CLAUDE.md (documentatie per patroon + welke componenten horen erbij), boilerplate-varianten. Eerst documenteren in CLAUDE.md, dan implementeren.

### Social Media Launch

58. [ ] [2026-06-10] `#idea` Create Tweety goose — posts on Twitter/X (target: 2026-09-01, social media V-Formation launch)

59. [ ] [2026-06-10] `#idea` Create Linky goose — posts on LinkedIn (target: 2026-09-01, social media V-Formation launch)

- [ ] [2026-06-14] `#app:proofofread` **Rebuild proofofread using newapp structure** — App was built before the standard newapp template existed. Has old layout: `frontend/` subfolder for Vite, separate `api/` dir, root `dist/` for static files. Modern apps have Vite at root with `dist/`, single nginx block, no `frontend/` subfolder. When rebuilding: run `newapp proofofread` pattern, migrate `api/` backend, use boilerplate auth/Nostr hooks. Icon fixed (nginx icons rule added to goosielabs.com block — was only on nsite block before).
