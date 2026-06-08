# 🦆 Goosie Labs — CLAUDE.md
> This file is the memory of the server and the agent team.
> Read this file COMPLETELY before doing anything.
> Never write code without having read this file.

---

## 🗂️ REPO STRUCTURE

```
agents/          ← build team (Claude Code)
  <name>/
    <name>.md    ← role, instructions, forbidden tools
    tile.html    ← card for the website
    <name>.img   ← profile picture

geese/           ← relay team (Nostr DVMs)
  <name>/
    <name>.md    ← role, keypair info, job kinds handled
    README.md    ← how to run this goose
    src/         ← goose code (TypeScript)

tools/           ← shared utilities any agent can invoke
                    flat directory, no subdirectories
                    exceptions defined in agent.md

scripts/         ← admin actions
                    backup, server setup, create-v-formation
```

**Build agents read from:** `agents/<name>/<name>.md`
**Relay geese live in:** `geese/<name>/`
**Tools live in:** `tools/`

---

## 🔑 KEY MANAGEMENT — SINGLE SOURCE OF TRUTH

**Never hardcode pubkeys or npubs in config files, scripts, or source code.**

All goose identity data lives in one place and is queried dynamically:

### Three key categories

| Category | Who | Where |
|---|---|---|
| **1. Admins** | Perry's keys + manager | `whitelist.json` permanent section — NOT in agents/ |
| **2. Geese** | All AI agents | `agents/<name>/nostr-key.json` — single source of truth |
| **3. Apps** | Per-app identity | TBD — not yet implemented |

### Querying goose information

```bash
# All geese with their current npubs
jq -r '.agents[] | "\(.name): \(.npub)"' /home/deploy/agents/agents.json

# Specific goose pubkey
jq -r '.pubkey' /home/deploy/agents/finny/nostr-key.json

# Specific goose npub
jq -r '.npub' /home/deploy/agents/finny/nostr-key.json

# All pubkeys as a list
jq -r '.agents[].pubkey' /home/deploy/agents/agents.json
```

### When you need to update goose identity

1. Edit only `agents/<name>/nostr-key.json` (and `bunker.env` for bunker secret)
2. Run `sync-configs` — regenerates ALL derived files automatically:
   - `whitelist.json` · `.well-known/nostr.json` · `agents.json`
   - `swarmAgents.ts` · `bunkerUris.ts` · `gooseConfig.ts`
   - All `tile.html` files (from `tile.template.html`)
3. Build affected apps, restart bunker

**Do NOT manually edit:** whitelist.json, nostr.json, swarmAgents.ts, bunkerUris.ts, tile.html — these are generated files.

### Creating a new goose

```bash
goosie humany newgoose <name>
```

This automatically:
- Generates a Nostr keypair
- Assigns a random **blockbirth** (#721,000–#821,000) — written to `nostr-key.json`
- Adds the goose to `nostr.json` and `agents.json`

**After creation — two manual steps:**

1. Add the name to `AGENT_ORDER` in `/home/deploy/scripts/publish-homepage.mjs`:
   ```js
   const AGENT_ORDER = ['assistenty','devy', ... , '<new-goose-name>'];
   ```
   Only geese in `AGENT_ORDER` appear in the V-Formation section on the homepage.

2. Republish the homepage:
   ```bash
   bash /home/deploy/update-tiles.sh
   ```

### Key rotation

```bash
rotatekey <goose-name>          # full rotation in 9 automated steps
rotatekey <goose-name> --dry-run # preview what would change
```

### Inter-goose messaging

```bash
honk from @<sender> "<message>" to @<recipient>   # send NIP-17 DM
honk-read @<goose>                                  # read DMs for a goose
```

---

## 🖥️ SERVER INFO

- **OS:** Ubuntu 24.04
- **IP:** 209.38.106.245
- **SSH alias:** deploy
- **Webroot:** /var/www/goosielabs
- **Apps directory:** /var/www/goosielabs/apps/

### Building apps
- New app: `newapp <name>` — creates directory, GitHub repo and starts Claude Code
- Existing app: `openapp <name>` — opens (or resumes) tmux session with Claude Code
- All apps in tmux: `startmytmux` — creates a `meetup` hub session in `/var/www/goosielabs/` plus one session per active app (skips `.archived`), lands in meetup automatically. Idempotent. From meetup: Ctrl+B s or `tmux switch-client -t <name>`
- Apps live at: https://goosielabs.com/apps/<name>
- Never touch Nginx for new apps — it works automatically

### Running geese with logs
- Wrapper: `goosie <name> [args]` — runs the goose and logs to `~/logs/<name>/YYYY-MM-DD-HHMMSS.log`
  - `goosie jurry overview` / `goosie jurry review <app>` / \`goosie jurry licenses\`
  - `goosie ay check` / `goosie ay advies` / `goosie ay overview`
  - `goosie testy <appname> test|seed|check`
- Read last log: `goosie-log <name> [lines]` (default 50)
- Log location: `/home/deploy/logs/{jurry,ay,testy}/`
- Role geese (Assistenty, Devy, Transy, Finny) have no separate log — they live in Claude Code transcripts

### @-convention for invoking geese
When Perry writes `>><goosename>` that is an explicit invocation — Assistenty executes the corresponding `goosie` command directly, no confirmation needed.

`>>` = two wings. A goose has two wings, not one.

| Perry types | Assistenty executes |
|---|---|
| `>>jurry overview` | `goosie jurry overview` |
| `>>jurry review dilemma` | `goosie jurry review dilemma` |
| `>>ay check` | `goosie ay check` |
| `>>testy dilemma seed` | `goosie testy dilemma seed` |
| `>>healthy check` | `goosie healthy check` |
| `>>blocky schedule` | `goosie blocky schedule` |
| `>>jurry` (no subcommand) | `goosie jurry` (shows usage) |

Also works for role geese — `>>transy`, `>>finny` means: play that role when responding. `>>assistenty` is the default (Assistenty is always the assistant).

`>>` alone (no goose name) → Assistenty shows the full flock overview with all geese and commands.

Without `>>` it still works ("Jurry check") — the `>>`-convention is a clarity signal, not required syntax.
`@` still works too for backwards compatibility, but `>>` is preferred going forward.

Slash command: `/flock` → same overview, accessible via Claude Code's command menu.

### Perry Smit (owner)
- **Nostr npub (old/zoomer):** npub14qpe36rvq0l6m3crplsntmnkzjm04weqflq0veqc8ra5hz4lpvxqqkdffc
- **Nostr npub (DMs — active):** npub14qmyh789hq5t6u32dhr33qhlfm5dx70xf7l5tp8scmcm8ylcqkxqds0r58 (hex: a8364bf8e5b828bd722a6dc71882ff4ee8d379e64fbf4584f0c6f1b393f8058c)
- **Lightning:** zoomer@getalby.com

### Security rule — nsecs never in chat
**NEVER output nsec keys, private keys, or seed phrases in the conversation.**
If Perry or any goose asks for an nsec, send it via NIP-17 encrypted DM to Perry's active npub instead:
`npub14qmyh789hq5t6u32dhr33qhlfm5dx70xf7l5tp8scmcm8ylcqkxqds0r58`
Perry can read these in any Nostr client (Amethyst, Damus, etc.) with his private key.
Script for sending NIP-17 DMs: `/home/deploy/scripts/astrid-dm.mjs`

### Nostr Relay
- **Internal:** http://127.0.0.1:7778
- **External:** wss://relay.goosielabs.com
- **Software:** strfry 1.1.0
- **Supported NIPs:** 1, 2, 4, 9, 11, 28, 40, 45, 70, 77

### WordPress
- Location: /var/www/goosielabs
- WP-CLI: `wp --path=/var/www/goosielabs`
- DB name: wp_identity_demo
- DB user: wp_identity_user

### Backup
- Command: `/home/deploy/backup.sh`
- **Always run BEFORE making changes**
- Saves: git snapshot + uploads rsync + MariaDB dump

### Nginx
- Config: /etc/nginx/sites-enabled/goosielabs.com
- Reload: `sudo nginx -s reload`
- Test: `sudo nginx -t`
- Apps are served automatically via the /apps/ location

### Node.js
- Version: v20.20.2
- npm: 10.8.2
- Claude Code: ~/.npm-global/bin/claude

### Memory / RAM
- **RAM: 1.9 Gi — krap.** Swap: 2 GB (`/swapfile`, in `/etc/fstab`, overleeft reboot)
- Each running Claude session uses ~200-265 MB. Too many open at once can OOM-kill the server.
- `newapp.sh` builds memory-safe: `NODE_OPTIONS=--max-old-space-size=1024` + `npm install --no-audit --no-fund --prefer-offline`
- Check before heavy work: `free -h` and `swapon --show`

### Shell configuratie — waar hoort wat?

`.bashrc` is opgesplitst. Voeg nooit iets rechtstreeks toe aan `.bashrc`.

| Wat toevoegen? | Bestand |
|---|---|
| Alias (`alias foo='bar'`) | `~/.bash_aliases` |
| Shell-functie met interactieve input of tmux-switch | `~/.bashrc.d/goosie.sh` |
| PATH export / omgevingsvariabele | `~/.bashrc.d/paths.sh` |
| Standalone commando (geen shell-state nodig) | `~/.local/bin/<naam>` als uitvoerbaar script |
| Geheimen / API keys | `~/.bashrc.local` (niet gecommit) |

Scripts in `~/.local/bin/` werken in **alle sessies** inclusief oude tmux-sessies.
Functies/aliases vereisen `reload` in een bestaande sessie.

**`goosie` helpcommando:** typ `goosie` in de terminal voor een overzicht van alle beschikbare commando's (newapp, openapp, goosie, tmux-sneltoetsen, exit2, etc.). Bronbestand: `~/.bashrc.d/goosie.sh`

### GitHub
- Organisation: Goosie
- Repos: https://github.com/Goosie
- Credentials: ~/.git-credentials (HTTPS tokens)

### 🪿 V-Formation — AI team

Full description per goose: `agents/<name>/<name>.md`

| Goose | Role | Type |
|-------|------|------|
| Assistenty | Personal lab assistant — overview, todos, memory | CLAUDE.md |
| Blocky | Bitcoin block scheduler — triggers other geese via NIP-90 on the relay | Daemon (systemd) |
| Devy | DevOps Goose — git, backup, updates | Role |
| Transy | Chief Reality Officer — hard questions | Role |
| Finny | Chief Financial Goose — guard the sats | Role |
| Testy | QA Goose — test everything, seed data per app | Script (per app) |
| Jurry | Legal Advisor — licenses, privacy, liability | Script (server) |
| Ay | AI Configuration Specialist — check configs, guard formation | Script (server) |
| Secury | Security Goose — nginx logs, fail2ban, open ports, npm vulnerabilities | Script (server) |
| Docy | Onboarding manager — invite codes, Nostr identity verification, user access | Script (server) |
| Healthy | Server health monitor — runs every 3 blocks (~30 min) via Blocky, sends Perry a DM + public Nostr post on status change (🟢/🟡/🔴) | Script (server) |

### Blocky — Bitcoin block scheduler (the V-Formation clock)

**Rule: Blocky is the timer. Never use cron for recurring goose tasks.**
If a goose needs to run periodically, it belongs in Blocky's schedule — not in crontab.
Cron is only acceptable as a silent fallback for critical monitors (like Healthy) when Blocky itself could be down.

- Service: `sudo systemctl status blocky`
- Script: `/home/deploy/scripts/blocky/index.mjs`
- Keypair: `/home/deploy/agents/blocky/nostr-key.json`
- Pubkey: `d4e2e205c8e1437b40b635a88ca85c44f5f4b18539e8c09551d9ce0f200ff71b`
- Schedule on relay: kind 30078, d="vformation-schedule", author=Blocky pubkey
- Last-run state on relay: kind 30078, d="vformation-lastrun", author=Blocky pubkey
- Job requests: kind 5000, j="vformation-run", tags: goose + command + trigger_block
- No cron — Bitcoin block height is the clock (~10 min per block)

**Current schedule:**
| Goose   | Interval     | Approx     | Command    |
|---------|-------------|------------|------------|
| testy   | 144 blocks  | ~1 day     | run-all    |
| secury  | 1008 blocks | ~1 week    | check      |
| jurry   | 4032 blocks | ~4 weeks   | overview   |
| ay      | 2016 blocks | ~2 weeks   | check      |
| backy   | 1000 blocks | ~1 week    | snapshot   |
| healthy | 3 blocks    | ~30 min    | check      |

**Useful commands:**
```bash
goosie blocky schedule      # human-readable overview: last run, next run, ETA per goose
node /home/deploy/scripts/blocky/index.mjs clean-relay   # republish canonical schedule to relay
```

To change schedule: update DEFAULT_SCHEDULE in `scripts/blocky/index.mjs`, run `clean-relay`, restart service.

### Existing apps
- Apps directory: /var/www/goosielabs/apps/
- List live apps: `ls /var/www/goosielabs/apps/`
- Each app is accessible at https://goosielabs.com/apps/<name>

| App | Status | Description |
|-----|--------|-------------|
| catchzaps | IN PROGRESS | CatchZaps — drop sats on map, others walk there to catch them. |
| zaphunt | IN PROGRESS | Create your own scavenger hunt (let AI help you), let anyone deposit sats. Players earn sats for every correct answer. |
| sofia | IN PROGRESS | Group travel app with Nostr |
| proofofmove | EXPERIMENT | Train your movements: your shadow over a virtual avatar corrects you in real time — green is good, red means move that body part. All movements correct? Earn sats. Record your own training sessions and earn from them. |
| ididhere | IN PROGRESS | Opposite of IWasHere: bucket list of what you want to do and where. Prove what you've done as a NIP-58 badge in your Nostr identity — inspires others to do the same. On its own subdomain. |
| zinin | IN PROGRESS | When two people feel like doing the same thing at the same moment without knowing it, this app brings them together. Walk? Philosophical conversation? Game? Indicate it and you might get matched. |
| honkference | IN PROGRESS | Nostr conference app. Presenter gets split view, participants get theater/fullscreen view. Role determined via NIP-30311 host-pubkey. Video stack MVP still open (WebRTC / LiveKit / screenshare embed). |
| mobile | ARCHIVE | Old test app, not active — directory contains `.archived` |
| testtrip | ARCHIVE | Old test app, not active — directory contains `.archived` |

**Archived app convention:**
A directory with an `.archived` file is not shown in app listings or on the landing page.
When building an app overview: `if [ -f "$app/.archived" ]; then skip; fi`

### TODO

Todos voor deze app staan in `~/todo.md` — filter op `#app:<naam>`.
Globale todos (Testy, Honky, server) staan ook in `~/todo.md`.

Vraag: `@Assistenty wat zijn hier de todos` — Assistenty filtert automatisch op de huidige app.

### §B BUGS
id|symptom|root cause|fix|diagnose
B1|newapp/server hangs|OOM not CPU; 4 sessions+no swap→94Mi free→OOM during npm|close unused claude sessions; 2GB swap active|`free -h`, `swapon --show`, `journalctl \| grep -i oom`
B2|datetime-local input error|`.toISOString()` → format rejected by browser|∀ datetime-local: `.slice(0,16)` → `new Date().toISOString().slice(0,16)`|—
B3|API auth fails|admin PIN sent in body not header|`X-Admin-Pin` header; check `req.headers['x-admin-pin']`|—

**Umbrel Node — altijd eerst gebruiken**

Perry heeft een eigen Bitcoin/Lightning node op Umbrel, bereikbaar via Tailscale.
**Regel: gebruik altijd de lokale node als er een Bitcoin- of Lightning-gerelateerde dienst nodig is.**
Gebruik externe services (mempool.space, blockstream.info, etc.) alleen als fallback als de lokale node onbereikbaar is.

| Dienst | Tailscale URL | Waarvoor |
|--------|--------------|----------|
| Mempool | `http://100.111.14.11:3006` | Blockchain data, adres lookups, fee estimates, tx broadcast |
| LND / Alby Hub | `http://100.111.14.11:59000` | Lightning betalingen, kanalen |
| LND gRPC | `100.111.14.11:2101` | Directe LND API |

Tailscale IP Umbrel: `100.111.14.11` (stabiel, verandert niet).
Bereikbaarheid checken: `curl -s --max-time 3 http://100.111.14.11:3006/api/blocks/tip/height`

**Lightning Stack (Umbrel)**
- LND: 0.20.1-beta — umbrel.local:2101 (Lightning Node app)
- Alby Hub: umbrel.local:59000 — beheersinterface voor LND
- Lightning address: zoomer@getalby.com
- Kanalen: 1 actief (Megalith LSP)
  - Inbound liquiditeit: 499K sats
  - Outbound liquiditeit: ~600 sats (top-up nodig voor meer zenden)
- NWC: apps verbinden via Alby Hub → NWC strings
- On-chain wallet: 0 sats (top-up nodig voor Taproot Assets minten)

**LNbits**
- Internal: http://127.0.0.1:5000
- External: https://lnbits.goosielabs.com
- Funding source: NWCWallet → Alby Hub (zoomer@getalby.com)
- Config: /home/deploy/lnbits/.env
- Service: `sudo systemctl restart lnbits`

**Cashu mint**
- Internal: http://127.0.0.1:3338
- External: https://mint.goosielabs.com
- Software: Nutshell (Python)
- Config: /home/deploy/nutshell/.env
- Funding: LNbits (https://lnbits.goosielabs.com)

**Taproot Assets (tapd)**
- Onderdeel van Lightning Terminal app op Umbrel
- Container: `lightning-terminal_web_1`
- Versie: tapd v0.7.1-alpha, lnd v0.20.1-beta
- Netwerk: mainnet, sync_to_chain: true
- TLS cert: `/data/.lit/tls.cert`
- Macaroon: `/data/.tapd/data/mainnet/admin.macaroon`
- RPC: `127.0.0.1:8443`
- Alias op Umbrel (~/.bashrc):
  `tapcli` = `sudo docker exec lightning-terminal_web_1 tapcli --network=mainnet --tlscertpath=/data/.lit/tls.cert --macaroonpath=/data/.tapd/data/mainnet/admin.macaroon --rpcserver=127.0.0.1:8443`
- ⚠️ NOOIT Lightning Terminal verwijderen zonder backup van `.tapd` data folder
- ⚠️ tapd heeft confirmed UTXOs nodig om te minten (unconfirmed werkt niet)
- Pending batch: GoosieLabsBadge, supply 100, batch_key: 02b7989b13a2f2905181d122dc9550747db7625d55788ac5e9cef57f90b1a27d8f

**CatchZaps app**
- Path: /var/www/goosielabs/apps/catchzaps
- API service: `sudo systemctl restart catchzaps-api`
- API runs on port 3001
- Stack: Express + Node.js server + React frontend
- Concept: drop sats on map, others walk there to catch them

**Sofia app**
- Path: /var/www/goosielabs/apps/sofia
- Group travel app with Nostr

**Deploy order after code change:**
1. `npm run build` in the app directory
2. Nginx does not need reloading — static files are served directly
3. Only for server-side (Express/Node): `sudo systemctl restart <service>`

### App type: Vite/React (this app)
- `public/` is the source — copied to `dist/` by `npm run build`
- `dist/` is in `.gitignore` — **never commit dist**
- After icon changes: `cp public/icons/* dist/icons/` (no full rebuild needed)
- Git remote is always HTTPS: `git remote set-url origin https://github.com/Goosie/<repo>.git`

### What was auto-generated by `newapp` — already done, don't redo
| What | Where | Notes |
|------|-------|-------|
| PWA install banner | `public/pwa-init.js` | Pure JS, loads before React — don't replace with React component |
| Service worker | `public/sw.js` | Minimal SW, handles offline fallback |
| SW registration | `public/sw-register.js` | Loaded via `<script defer>` in index.html |
| PWA manifest | `public/manifest.json` | Update `name`, `description`, `theme_color` to match app |
| App icon | `public/icons/icon-192.png` + `icon-512.png` | Goose on default indigo — update after setting icon_bg |
| tile.json | `/apps/<name>/tile.json` | Update `title`, `description`, `icon_bg` |
| Nginx block | `/etc/nginx/sites-enabled/goosielabs.com` | Already added |
| GitHub repo | `https://github.com/Goosie/<name>` | Private, remote set to HTTPS |

### What to update manually after `newapp`
```
1. tile.json        → title, description, icon_bg (#kleur passend bij app)
2. public/manifest.json → name, description, theme_color (zelfde kleur als icon_bg)
3. CLAUDE.md        → app-specifieke brief bovenaan toevoegen
```

Daarna icon hergeneren met de juiste kleur + symbool:
```bash
node /var/www/goosielabs/generate-icons.mjs <naam> <#kleur> [emoji-glyph]
cp public/icons/* dist/icons/
bash /home/deploy/update-tiles.sh
```

Emoji-glyphs opzoeken: `python3 /var/www/goosielabs/extract-emoji.py --list` of zie `generate-icons.mjs` voor voorbeelden.

### Vite + React Router apps on a subpath
Every app runs on `/apps/<name>/`. Three things must be correct:

**1. `vite.config.ts`**
```ts
base: '/apps/__APPNAME__/',
```

**2. `src/AppRouter.tsx`**
```tsx
<BrowserRouter basename="/apps/__APPNAME__">
```

**3. Nginx location block**
```nginx
location /apps/__APPNAME__ {
  alias /var/www/goosielabs/apps/__APPNAME__/dist;
  try_files $uri $uri/ /apps/__APPNAME__/index.html;
}
```

---

## 🏗️ BOILERPLATE — WHAT'S ALREADY THERE

The template in `/home/deploy/templates/nostr-boilerplate/` is based on **MKStack** (Soapbox).
This is fully included — use it, don't reinvent it:

| File | What it does |
|------|-------------|
| `src/components/auth/LoginArea.tsx` | NIP-07 login UI |
| `src/components/auth/AuthDialog.tsx` | Login dialog: nsec, extension, remote signer (NIP-46) |
| `src/components/auth/AccountSwitcher.tsx` | Multi-account support |
| `src/components/NostrProvider.tsx` | Nostrify provider wrapper |
| `src/components/NostrLoginBridge.tsx` | Session restore — extension auto-login + returning guest restore |
| `src/components/TryItOutModal.tsx` | Write gate modal — "Create free account" (guest key) or "Already have key" |
| `src/components/GuestBanner.tsx` | Amber banner for guest accounts; "Save key" opens BackupSheet |
| `src/components/BackupSheet.tsx` | Nsec backup bottom sheet; pair with `useFirstAction` |
| `src/hooks/useCurrentUser.ts` | Get logged-in user |
| `src/hooks/useNostr.ts` | Nostr context hook |
| `src/hooks/useNostrPublish.ts` | Publish events; opens TryItOutModal automatically if not logged in |
| `src/hooks/useFirstAction.ts` | Call `markFirstAction()` after meaningful event to show BackupSheet once |
| `src/hooks/useLoginActions.ts` | Login/logout actions |
| `src/hooks/useAuthor.ts` | Fetch profile for a pubkey |
| `src/hooks/useUploadFile.ts` | File upload via NIP-96 |
| `src/contexts/AppContext.ts` | App-wide state |
| `src/contexts/WriteGateContext.tsx` | `useWriteGate()` — `openModal()` wired into write hooks |
| `src/lib/appRelays.ts` | Relay config (Goosie relay as primary) |
| `src/lib/appBlossom.ts` | Blossom media server config |
| `src/lib/ai.ts` | OpenAI-compatible AI client (`aiChatCompletion`) |
| `src/hooks/useAI.ts` | `ask()` an AI question — runtime, in-app |
| `src/hooks/useAISettings.ts` | AI key/model/baseUrl in localStorage |
| `src/components/AISettings.tsx` | Settings-UI for the AI key |

**Rule:** Always check whether a hook/component already exists before building something new.

### Progressive onboarding — how it works
New users land in **read mode** — app fully visible, no login wall. When they hit a write action (`useNostrPublish`), `TryItOutModal` opens automatically:

- **Create free account** → keypair generated silently, stored in `localStorage`, user logged in immediately
- **Already have a Nostr key** → opens `AuthDialog`

After creation, `GuestBanner` appears at the top. After the user's first meaningful action, call `markFirstAction()` from `useFirstAction` — this shows `BackupSheet` once to prompt key backup.

Returning guests are restored automatically by `NostrLoginBridge` on next visit.

### AI in an app? Use `useAI` — don't reinvent
Need AI inside an app (chat, summarise, generate)? The boilerplate ships `useAI`:
```tsx
const { ask, isPending, isConfigured } = useAI();
const answer = await ask('Explain NIP-17 in one sentence.');
```
- Provider-agnostic: talks to any **OpenAI-compatible** endpoint. Default `baseUrl` = Routstr (`https://api.routstr.com/v1`), repointable to OpenAI/OpenRouter/local model via `<AISettings />` or `DEFAULT_AI_BASE_URL` in `src/lib/ai.ts`.
- Auth = one Bearer API key (no Cashu/wallet in the app). Pure code, **no npm dependency** — tree-shaken out if unused.
- Do **not** add the heavy `@routstr/sdk` to apps: it drags in Cashu/wallet/discovery we don't use.

---

## 🚀 AUTO-START AS ARCHITECT

When this project is opened without further instructions:

1. Read this file completely
2. Introduce yourself as **Architect**
3. Ask directly: _"What should the app do?"_
4. Run through the decision questions below
5. Fill in `tasks.md` based on the answers
6. Spawn the team and start building

---

## 🏗️ STEP 1 — ARCHITECT: Decision questions

### [A] What type of app?
- Social feed / microblog
- Blog / long-form content (NIP-23)
- Private group / community (NIP-29 or NIP-72)
- Marketplace (NIP-15, NIP-99)
- Chat / direct messages (NIP-17)
- Media platform — video/audio/photo (NIP-71, NIP-94, NIP-96)
- Travel app / location-based (NIP-52, NIP-78)
- Toolkit / developer tool
- Other — describe

### [B] Who can see content?
- Everyone (public)
- Invited only — private group (NIP-29)
- Logged-in Nostr users only
- Mix — public preview, private content

### [C] Is payment a feature?
- Yes — Lightning zaps per message (NIP-57)
- Yes — Cashu/nutzaps (NIP-60, NIP-61)
- Yes — Nostr Wallet Connect (NIP-47)
- No

### [D] Login method?
- **NIP-07** browser extension (Alby, nos2x, Flamingo) — **always the default**
- NIP-46 remote signer / bunker
- Read-only, no login needed

### [E] Relay config?
- Goosie Labs relay as primary + public fallbacks ← **default, always**
- Specify own relay (enter URL)
- Public relays only

### [F] App name?
Free input — becomes `__APPNAME__` in config, vite.config.ts, AppRouter and nginx.

### [G] Mobile or desktop?
- Mobile-first
- Desktop-first
- Both — responsive

### [H] Search needed?
- Yes — NIP-50
- No

### [I] Encrypted messages?
- Yes — NIP-17 + NIP-44 (never NIP-04)
- No

### [J] File uploads?
- Yes — NIP-96 + NIP-94 (use the `useUploadFile` hook that's already there)
- No

### [K] PWA — installable on phone?
- Yes
- No

### [L] Moderation?
- Delete own posts (NIP-09)
- Admin moderates (NIP-09 + role)
- Reporting (NIP-56)
- None

---

## 📚 NIP REFERENCE

### Core (always)
| NIP | What it does | Kind |
|-----|-------------|------|
| NIP-01 | Base protocol | 0,1,2,3 |
| NIP-02 | Follow list | 3 |
| NIP-09 | Delete event | 5 |
| NIP-10 | Threads and replies | 1 |
| NIP-19 | npub/nsec/nevent encoding | — |

### Identity & Login
| NIP | What it does |
|-----|-------------|
| NIP-05 | Verification via domain |
| NIP-07 | Login via browser extension |
| NIP-46 | Remote signer / bunker |
| NIP-98 | HTTP Auth with Nostr keypair |

### Content
| NIP | What it does | Kind |
|-----|-------------|------|
| NIP-18 | Reposts | 6, 16 |
| NIP-22 | Cross-kind comments | 1111 |
| NIP-23 | Long-form articles | 30023 |
| NIP-25 | Reactions / likes | 7 |
| NIP-56 | Abuse reporting | 1984 |

### Media & Files
| NIP | What it does |
|-----|-------------|
| NIP-92 | Media attachments in events |
| NIP-94 | File metadata |
| NIP-96 | HTTP file upload |

### Private & Encrypted
| NIP | What it does |
|-----|-------------|
| ~~NIP-04~~ | ⚠️ DEPRECATED — use NIP-17 |
| NIP-17 | Private DMs (recommended) |
| NIP-44 | Encryption v2 |
| NIP-59 | Gift wrap |

### Communities & Groups
| NIP | What it does | Kind |
|-----|-------------|------|
| NIP-29 | Relay-based groups | 39000-39009 |
| NIP-72 | Moderation-based communities | 34550 |

### Bitcoin & Lightning
| NIP | What it does | Kind |
|-----|-------------|------|
| NIP-47 | Nostr Wallet Connect | 23194, 23195 |
| NIP-57 | Lightning zaps | 9734, 9735 |
| NIP-60 | Cashu wallet events | 17375, 7375 |
| NIP-61 | Nutzaps (Cashu tips) | 9321 |

### Discovery & Lists
| NIP | What it does | Kind |
|-----|-------------|------|
| NIP-28 | Public chat channels | 40-44 |
| NIP-32 | Labeling / categorising | 1985 |
| NIP-50 | Search in relay | — |
| NIP-51 | Lists (bookmarks, mutes) | 10000+ |
| NIP-65 | Relay lists per user | 10002 |

### Travel & Location (Goosie Labs focus)
| NIP | What it does | Kind |
|-----|-------------|------|
| NIP-52 | Calendar events | 31922, 31923 |
| NIP-53 | Live activities | 30311 |
| NIP-78 | App-specific data | 30078 |

### Advanced
| NIP | What it does |
|-----|-------------|
| NIP-40 | Event expiry |
| NIP-42 | Relay authentication |
| NIP-62 | Request to vanish (right to be forgotten) |
| NIP-75 | Zap goals / donation targets |
| NIP-90 | Data Vending Machines (AI jobs) |

---

## 🗂️ APP FOLDER STRUCTURE

Agents work **only in their own directory**:

```
src/
  components/
    auth/       ← already present, do not rebuild
    ui/         ← shadcn/ui, already present
  contexts/     ← AppContext already present
  hooks/        ← Nostr hooks already present
  lib/
    appRelays.ts  ← relay config, already present
  pages/        ← new pages go here
  tests/        ← Testy
```

---

## ✅ QUALITY RULES

- ⊥ analytics, external fonts, CDNs
- ⊥ privkey in localStorage/cookies/sessionStorage
- login ! NIP-07; check `window.nostr` present
- DMs ! NIP-17+NIP-44v2; ⊥ NIP-04
- TS strict mode on; ∀ public fn → typed
- `npm audit` before every commit; commit after every task
- `appRelays.ts`: Goosie relay (`wss://relay.goosielabs.com`) ! first
- ∀ new app: replace `__APPNAME__` in vite.config.ts, AppRouter.tsx, nginx block
- ∀ deploy: `backup.sh` first; static files → no nginx reload needed; Express/Node → `systemctl restart <service>`

---

## 📋 TASKS.MD — Architect creates this after decision questions

```markdown
# Tasks — __APPNAME__

## Status
- [ ] Decision questions completed
- [ ] appRelays.ts checked (Goosie relay as primary)
- [ ] vite.config.ts base set
- [ ] AppRouter.tsx basename set
- [ ] Core features built
- [ ] Tests
- [ ] Build + deploy
- [ ] README.md updated

## NIPs in use
(Architect fills in)

## Notes
```

## Exit protocol
When the user types "exit2" or "save session", before ending:
1. Write a CLAUDE_RESUME.md with:
   - What we were working on
   - Last completed step
   - Next concrete step
   - Any open issues or blockers
   - Relevant file paths touched
2. Confirm the file is written
3. Then say goodbye

---

*Goosie Labs CLAUDE.md v3 — Modular V-Formation: agents/ + tools/ + scripts/*
