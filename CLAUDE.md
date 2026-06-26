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

---

## 🗝️ API KEY MANAGEMENT — CONVENTION

### Rule: one central file for shared keys

All server-level and shared API keys live in ONE place:

```bash
nano /home/deploy/.env.services   # view or edit
```

**Do NOT put shared keys in:** `.bashrc.local`, individual app `.env` files, service `Environment=` inline, or source code.

### When to use which file

| File | What goes here |
|---|---|
| `/home/deploy/.env.services` | Shared keys: Anthropic, OpenAI, DigitalOcean, Gitea, any key used by >1 service |
| `/var/www/goosielabs/apps/<name>/.env` | App-specific keys only: LNbits wallet keys, per-app nsecs, ENCRYPTION_KEY |
| `/home/deploy/.bashrc.local` | Perry's personal nsec (interactive shell only — never for services) |

**For publishing scripts that need PERRY_NSEC:** Source `~/.bashrc.local` before running — e.g., `source ~/.bashrc.local && node /home/deploy/scripts/publish-homepage.mjs`. This makes `PERRY_NSEC` available for signing without exposing it in logs.

### How services load keys

Services that need shared keys use two `EnvironmentFile=` lines — shared first, app-specific second:

```ini
EnvironmentFile=/home/deploy/.env.services
EnvironmentFile=/var/www/goosielabs/apps/<name>/.env
```

If only shared keys are needed (no app-specific env):

```ini
EnvironmentFile=/home/deploy/.env.services
```

### How scripts load keys

Scripts run via `goosie` or the shell automatically get `.env.services` keys because `~/.bashrc.d/paths.sh` sources the file. No explicit loading needed.

For scripts run via systemd (daemons), the `EnvironmentFile=` in the service handles it.

### Adding a new API key

1. Add it to `/home/deploy/.env.services` (format: `KEY=value`, no `export`)
2. Update the inventory table below
3. If a new service needs it: add `EnvironmentFile=/home/deploy/.env.services` to the `.service` file
4. Reload: `sudo systemctl daemon-reload && sudo systemctl restart <service>`

**Never put a new API key anywhere else first.** One place, always.

---

## 📋 API KEY INVENTORY — Perry's services

> This table exists so someone can take over if Perry is unavailable.
> Key values are never stored here — only where to find them and what they're for.
> **Edit keys:** `nano /home/deploy/.env.services`

| Variable | Provider | Where purchased | Used by | Notes |
|---|---|---|---|---|
| `ANTHROPIC_API_KEY` | Anthropic | console.anthropic.com | dm-listener, bookwriter-agent, zaphunt backend, newapp backend | Claude Haiku for AI replies |
| `OPENAI_API_KEY` | OpenAI | platform.openai.com | generate-agent-portraits, humany portrait generation | Portrait/image generation |
| `DO_API_TOKEN` | DigitalOcean | cloud.digitalocean.com | backy (weekly snapshots) | Server snapshot automation |
| `DO_DROPLET_ID` | DigitalOcean | cloud.digitalocean.com | backy | ID of the VPS droplet |
| `GITEA_TOKEN` | Self-hosted | git.goosielabs.com (Perry's Gitea) | gitty, gitea goose | Repo management |
| `GITEA_HOST/PORT/USER` | Self-hosted | git.goosielabs.com | gitty, gitea goose | Gitea connection config |
| `OPENROUTER_API_KEY` | OpenRouter | openrouter.ai | onboarding backend | AI model routing — in `apps/onboarding/backend/.env` |
| `LNBITS_ADMIN_KEY` | Self-hosted | lnbits.goosielabs.com | zaphunt, satquiz backends | Per-app wallet keys — stay in app `.env` |
| `ENCRYPTION_KEY` | Generated | — | zap-hunt APIs | Per-app — stay in app `.env` |

**Emergency access:** All service files are in `/etc/systemd/system/`. The server runs on DigitalOcean, SSH access via the `deploy` user. DigitalOcean console access requires Perry's account at cloud.digitalocean.com.

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
2. For keypair/blockbirth changes: syncing is automatic
3. For description/role changes: see "Syncing agent prompts" section below

**Do NOT manually edit:** whitelist.json, nostr.json, swarmAgents.ts, bunkerUris.ts, tile.html — these are generated files.

### Syncing agent prompts to agents.json

When you update a goose's description or role in `~/.claude/agents/<name>.md`, run:

```bash
sync-agents          # Update agents.json + regenerate nsite pages + homepage
sync-agents --dry-run # Preview changes before applying
```

This script:
1. Reads `description:` field from all `~/.claude/agents/*.md` prompt files
2. Updates `agents.json` with these descriptions (source of truth for public display)
3. Regenerates nsite profile pages via `publish-agent-pages.mjs`
4. Updates homepage tiles

The `.claude/agents/*.md` files are the canonical source of truth for agent roles. Editing them automatically keeps the public description in sync.

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
| `>>backy snapshot` | `backy snapshot` |
| `>>gander scout "topic"` | `goosie gander scout "topic"` |
| `>>jurry` (no subcommand) | `goosie jurry` (shows usage) |

Also works for role geese — `>>transy`, `>>finny` means: play that role when responding. `>>assistenty` is the default (Assistenty is always the assistant).

`>>` alone (no goose name) → Assistenty shows the full flock overview with all geese and commands.

Without `>>` it still works ("Jurry check") — the `>>`-convention is a clarity signal, not required syntax.
`@` still works too for backwards compatibility, but `>>` is preferred going forward.

Slash command: `/flock` → same overview, accessible via Claude Code's command menu.

### Multi-goose sparring — `>>` in, `<<` out

Role geese can be combined in one conversation as a dynamic roundtable.

| Perry types | What happens |
|---|---|
| `>>thinky` | Thinky joins — challenges the idea |
| `>>creaty` | Creaty joins — adds unexpected angles |
| `>>thinky >>creaty` | Both active simultaneously |
| `<<thinky` | Thinky leaves, rest stays active |
| `>>jurry` | Jurry joins the table |
| `<<` (no name) | All role geese leave — back to Assistenty only |

`>>` = goose arrives (two wings in). `<<` = goose departs (two wings out).

When multiple geese are active, each responds from their own perspective in the same message:
- *Thinky:* [challenge / sharp question]
- *Creaty:* [unexpected angle / "yes, and..."]

Perry steers the conversation and can swap geese at any moment.

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

**Daily (Blocky ~144 blocks) — LND + LNbits:**
- Script: `goosie scb-backup backup`
- LND `channel.backup` → `/home/deploy/backups/lnd-scb/` (14 versions)
- LNbits databases (6x), `.env`, cert, macaroon → `/home/deploy/backups/lnbits/` (14 versions)
- Offsite copy → `umbrel@100.111.14.11:/home/umbrel/lnbits-backup/` (second physical location)

**Weekly (Blocky ~1000 blocks) — Full server snapshot:**
- Backy triggers DigitalOcean snapshot via API
- Restore: DO dashboard → Snapshots → Create Droplet from snapshot

**Before big changes:**
- Command: `/home/deploy/backup.sh`
- Saves: git snapshot + ZapHunt SQLite

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
| Thinky | Creative sparring partner — challenges ideas before they become tasks. Invoke before building anything new. | Role |
| Blocky | Bitcoin block scheduler — triggers other geese via NIP-90 on the relay | Daemon (systemd) |
| Devy | DevOps Goose — git, backup, updates | Role |
| Transy | Chief Reality Officer — hard questions | Role |
| Finny | Chief Financial Goose — guard the sats | Role |
| Testy | QA Goose — test everything, seed data per app | Script (per app) |
| Jurry | Legal Advisor — licenses, privacy, liability | Script (server) |
| Ay | AI Configuration Specialist — check configs, guard formation | Script (server) |
| Secury | Security Goose — nginx logs, fail2ban, open ports, npm vulnerabilities | Script (server) |
| Docy | Onboarding manager — invite codes, Nostr identity verification, user access | Script (server) |
| Healthy | Server health monitor — runs every 4 blocks (~40 min) via Blocky, sends Perry a DM + public Nostr post on status change (🟢/🟡/🔴) | Script (server) |

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
| healthy | 4 blocks    | ~40 min    | check      |

**Useful commands:**
```bash
goosie blocky schedule      # human-readable overview: last run, next run, ETA per goose
node /home/deploy/scripts/blocky/index.mjs clean-relay   # republish canonical schedule to relay
```

To change schedule: update DEFAULT_SCHEDULE in `scripts/blocky/index.mjs`, run `clean-relay`, restart service.

### Removing a goose

```bash
goosie humany deletegoose <name>
```

Removes the goose from: agents dir, agents.json, whitelist, nostr.json, homepage, goose-runner, Blocky schedule, .claude/agents prompt, all flock sections. Rebuilds homepage + restarts services automatically.

Manual cleanup after: deactivate LNbits wallet if needed.

### Creating a new goose — full checklist

```bash
goosie humany newgoose <name>
```

**Automated by humany:**
- Nostr keypair + blockbirth → `nostr-key.json`
- nostr.json, agents.json, whitelist entries
- Icon (placeholder), portrait
- LNbits wallet + Lightning Address
- Kind:0 Nostr profile published
- Kind:10050 DM relay list published → `wss://relay.goosielabs.com` (NIP-17 inbox)
- NIP-58 badge awarded
- `agents/<name>/<name>.md` with `description:` placeholder
- `.claude/agents/<name>.md` template with quote/role/boundaries
- Nsite page published via `publish-agent-pages.mjs`
- Added to `AGENT_ORDER` + `AGENT_COLORS` in `publish-homepage.mjs` (gray placeholder)
- Homepage tiles updated with tile
- All existing agent prompts updated with new flock member in `## The Flock` table
- Welcome ceremony: Assistenty, Coachy, Blocky and Healthy post public welcome notes

**Manual after creation:**
1. Fill in `agents/<name>/<name>.md` — real `description:` (one line, English)
2. Fill in `.claude/agents/<name>.md` — real `quote:`, role, responsibilities, boundaries
3. Add to `generate-agent-icons.mjs` with real color + symbol → re-run icons
5. Run `node scripts/publish-agent-pages.mjs --agent <name>` after filling in quote/role
6. Add script at `scripts/<name>/index.mjs` if the goose runs tasks
7. Add to goose-runner `KEYS` + `switch case` → `sudo systemctl restart goose-runner`
8. Add to Blocky `DEFAULT_SCHEDULE` if periodic → `clean-relay` + restart blocky

### Goose Portrait Generation — How to create/update agent icons

**Standard approach: Cartoon goose portraits via `generate-agent-portraits.mjs`**

All goose portraits are flat 2D cartoon geese with specific outfits that represent their role. This ensures visual consistency across the V-Formation.

**Script location:**
```bash
/home/deploy/systemsetup/scripts/generate-agent-portraits.mjs
```

**How it works:**
1. Script uses OpenAI's `gpt-image-1` model
2. `BASE_STYLE` enforces consistent cartoon look (thick outlines, cel shading, orange beak/feet, warm cream background)
3. Each goose has a specific `prompt` describing their outfit + accessories + personality

**When you need a new/updated portrait:**

1. **Find or create the goose's prompt** in `generate-agent-portraits.mjs`:
   ```javascript
   {
     name: 'newgoose',
     prompt: `${BASE_STYLE}. Describe outfit, what they're holding, their expression/personality.`
   }
   ```

2. **Outfit description format** (follow the pattern):
   - ONE main outfit element (e.g., lab coat, hard hat, suit, robes)
   - ONE or two accessories they hold (clipboard, wrench, coin, gavel)
   - One sentence describing their personality/expression

3. **Generate the portrait:**
   ```bash
   source ~/.bashrc.local
   node /home/deploy/systemsetup/scripts/generate-agent-portraits.mjs <goosename>
   ```
   Creates: `/home/deploy/agents/<goosename>/adult_<goosename>.jpg`

4. **Copy to all locations:**
   ```bash
   cp /home/deploy/agents/<goosename>/adult_<goosename>.jpg /home/deploy/agents/<goosename>/<goosename>.jpg
   cp /home/deploy/agents/<goosename>/adult_<goosename>.jpg /var/www/goosielabs/agents/<goosename>/<goosename>.jpg
   ```

5. **Republish homepage:**
   ```bash
   bash /home/deploy/scripts/update-tiles.sh
   ```

**Example portraits (look at these for style reference):**
- **Assistenty:** lab coat, stethoscope, clipboard, glasses → wise researcher
- **Devy:** hard hat, tool belt, wrench → gruff engineer
- **Finny:** three-piece suit, top hat, monocle, Bitcoin coin → financier
- **Cssy:** mint-green tech outfit, color palette, design token → CSS architect
- **Coachy:** golden coach jacket, whistle, encouragement clipboard → warm motivator
- **Creaty:** rainbow paint smock, paintbrush, idea lightbulb → playful creative

**Do NOT use:** Realistic portraits, 3D renders, photos, cinematic banners. Those are for Designy's DALL-E banner generator only (separate workflow).

### Existing apps
- Apps directory: /var/www/goosielabs/apps/
- List live apps: `ls /var/www/goosielabs/apps/`
- Each app is accessible at https://goosielabs.com/apps/<name>

| App | Status | Description |
|-----|--------|-------------|
| zaphunt | IN PROGRESS | Create your own scavenger hunt (let AI help you), let anyone deposit sats. Players earn sats for every correct answer. |
| proofofmove | EXPERIMENT | Train your movements: your shadow over a virtual avatar corrects you in real time — green is good, red means move that body part. All movements correct? Earn sats. Record your own training sessions and earn from them. |
| ididhere | IN PROGRESS | Opposite of IWasHere: bucket list of what you want to do and where. Prove what you've done as a NIP-58 badge in your Nostr identity — inspires others to do the same. On its own subdomain. |
| zinin | IN PROGRESS | When two people feel like doing the same thing at the same moment without knowing it, this app brings them together. Walk? Philosophical conversation? Game? Indicate it and you might get matched. |
| honkference | IN PROGRESS | Nostr conference app. Presenter gets split view, participants get theater/fullscreen view. Role determined via NIP-30311 host-pubkey. Video stack MVP still open (WebRTC / LiveKit / screenshare embed). |
| mobile | ARCHIVE | Old test app, not active — directory contains `.archived` |
| testtrip | ARCHIVE | Old test app, not active — directory contains `.archived` |

**Archived app convention:**
A directory with an `.archived` file is not shown in app listings or on the landing page.
When building an app overview: `if [ -f "$app/.archived" ]; then skip; fi`

### Lightning payment UX — standaard patroon

**Regel: sluit altijd een betaal-modal na ontvangst. Gebruik LNbits WebSocket, niet polling.**

**Bewezen patroon (uit `/var/www/goosielabs/donate.js` en `goose-balances.js`):**

1. Genereer een invoice via `POST /api/v1/payments` met de wallet `inkey`
2. Toon QR van `payment_request`
3. Luister op `wss://lnbits.goosielabs.com/api/v1/ws/<payment_hash>`
4. LNbits stuurt `{"pending": false, "status": "success"}` → toon thank you → sluit modal

```javascript
// CORRECT: invoice genereren + luisteren op payment_hash
fetch(LNBITS + '/api/v1/payments', {
  method: 'POST',
  headers: { 'X-Api-Key': inkey, 'Content-Type': 'application/json' },
  body: JSON.stringify({ out: false, amount: 21, memo: 'Donate' })
}).then(r => r.json()).then(data => {
  showQR(data.payment_request);
  var ws = new WebSocket('wss://lnbits.goosielabs.com/api/v1/ws/' + data.payment_hash);
  ws.onmessage = e => {
    var msg = JSON.parse(e.data);
    if (msg.status === 'success' || msg.pending === false) showThankYou();
  };
});

// FOUT: wallet-level WebSocket of polling — onbetrouwbaar voor payment confirmation
// ws/<inkey>  ← geeft wallet events, niet invoice-specifieke bevestiging
// setInterval(() => fetchBalance(inkey), 2000)  ← NIET DOEN
```

**Implementatie in `/var/www/goosielabs/goose-balances.js`** — als referentie voor nieuwe betaal-UIs.

### Lessons Learned — Boeken bijhouden

Perry gebruikt `~/lessons/<naam>.md` om kennis vast te leggen tijdens trajecten.

**Commando's (in dit gesprek):**

| Perry typt | Assistenty doet |
|---|---|
| `Zet lessons learned in book <naam>: <les>` | Voegt les toe aan `~/lessons/<naam>.md` met datum |
| `Toon lessen <naam>` | Toont de inhoud van `~/lessons/<naam>.md` |
| `Genereer boek <naam>` | Gander synthetiseert alle lessen → publiceert als NIP-23 long-form op relay |

**Actieve boeken:**
- `~/lessons/lnd.md` — LND direct op LNbits aansluiten

**Formaat per les:**
```
### [YYYY-MM-DD] Titel van de les
Inhoud...
```

**Bookwriter integratie (TODO):** Bookwriter uitbreiden zodat het Nostr events leest als materials, dan kunnen lessen van de relay direct in de app verschijnen.

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

**Deploy order after code change:**
1. `npm run build` in the app directory
2. Nginx does not need reloading — static files are served directly
3. Only for server-side (Express/Node): `sudo systemctl restart <service>`

> 📦 App-building + Architect guide moved to /var/www/goosielabs/apps/CLAUDE.md — loads automatically when you work under apps/.

