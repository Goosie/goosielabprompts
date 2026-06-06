---
name: rename-goose-checklist
description: Complete checklist for renaming a goose — what the automated command handles vs what needs manual follow-up
metadata: 
  node_type: memory
  type: project
  originSessionId: b346f606-e724-468d-9b65-8b633da4bc31
---

# Renaming a goose — full procedure

## Step 1 — Run the automated command

```bash
goosie humany renamegoose <oldname> <newname>
```

This handles automatically (17 locations):
- `agents/<oldname>/` → `agents/<newname>/` (directory + file names)
- `agents/<name>/lnbits-wallet.json` — name, displayName, lightning_address
- LNbits live wallet — renamed via `PUT /api/v1/wallet/<NewName>` API
- `lnaddress` service restarted — new Lightning Address live immediately
- `.well-known/nostr.json` — NIP-05 entry
- `agents/agents.json` — name, nip05, picture URL
- `whitelist.json` — relay whitelist key
- `goose-runner/index.mjs` — dispatcher registration
- `gooseConfig.ts` — display name in vformation dashboard
- `generate-agent-icons.mjs` — name and label fields
- `generate-agent-portraits.mjs` — name field
- `publish-homepage.mjs` — AGENT_COLORS + AGENT_ORDER maps
- `publish-agent-pages.mjs` — AGENT_COLORS map
- `generate-agents-html.py` — COLORS dict + ORDER list
- `pages/homepage_base.html` — hardcoded agent card (name + description)
- `/var/www/goosielabs/agents/<name>/` — webroot portrait copy
- `.claude/agents/<name>.md` — role description used by homepage tile (frontmatter)
- Nostr kind:0 re-published with new name/nip05/lud16
- vformation dashboard rebuilt
- Homepage tiles updated

## Step 2 — Manual follow-up (4 things, always check these)

1. **`~/.claude/CLAUDE.md`** — update the agent name + description in the Actieve Projecten table
   - Gitignored — cannot be automated

2. **`agents/<newname>/<newname>.md`** — check/create the body text
   - File may not exist (wasn't tracked in git for older geese) — create it if missing
   - Body text may still say the old name — do a quick read and fix

3. **`agents/<oldname>/tile.html`** content (now renamed to `<newname>/tile.html`)
   - File is renamed but HTML inside may still say old display name
   - Check: `data-agent`, `alt`, `<h3>`, `<span class="agent-title">`, link text, `Meet <Name>` link

4. **Other agent .md files** — e.g. `agents/designy/designy.md` has a color table listing all agents
   - Run a grep after renamegoose to catch anything missed:
   ```bash
   grep -rn "<oldname>\|<OldName>" /home/deploy/agents/ /home/deploy/systemsetup/scripts/ \
     /var/www/goosielabs/apps/vformation/src/ \
     | grep -v "node_modules\|\.git\|community\|communication"
   ```

## Step 3 — Commit and push

```bash
# home-deploy repo
cd /home/deploy
git add agents/ && git commit -m "feat: rename <old> → <new>"
git push

# systemsetup repo
cd /home/deploy/systemsetup && git add scripts/ && git commit -m "chore: rename <old> → <new> in scripts" && git push

# vformation repo (gooseConfig.ts)
cd /var/www/goosielabs/apps/vformation
git add src/lib/gooseConfig.ts && git commit -m "chore: rename <old> → <new>" && git push
```

## What CANNOT be undone

- Old `<oldname>@goosielabs.com` Lightning Address stops working immediately
- Old `<oldname>@goosielabs.com` NIP-05 stops resolving — Nostr clients may have cached it
- Any published posts, zaps, or external references to the old name stay as-is

**Why:** The Nostr keypair (pubkey) never changes — only display metadata does. History is preserved.

## Step 2 — Additional grep sweep (always run after renamegoose)

```bash
grep -rn "<oldname>\|<OldName>" \
  /home/deploy/agents/ \
  /home/deploy/systemsetup/scripts/ \
  /var/www/goosielabs/apps/vformation/src/ \
  /var/www/goosielabs/apps/newapp/ \
  /var/www/goosielabs/apps/gooseprogrammer/ \
  /var/www/goosielabs/apps/swarm/ \
  2>/dev/null \
  | grep -v "node_modules\|\.git" \
  | grep -iv "community\|communication\|communiceer"
```
Commit each app repo separately (`git add <specific files>`, never `git add -A` in an app repo — may pull in unrelated staged files).

## Lessons learned from Astrid → Assistenty (2026-06-04)

- **`humany/index.mjs` hardcodes the badge-issuer key** — `astridKey`/`ASTRID_SK`/`ASTRID_PK` loads from `agents/astrid/nostr-key.json`. renamegoose renames the directory but the variable names in this file still compile against the path. **Must verify after rename that the path in `readFileSync(resolve(AGENTS_DIR, '<name>/nostr-key.json'))` matches the new name.**
- **`astrid-dm.mjs` (systemd service)** — key path updated, but file and service both named `astrid-dm`. Renaming the file would break the systemd unit. Left as-is. **Acceptable: the key path is the critical fix; the filename is just a label.**
- **`publish-badges.js`** — `BADGE_IMAGE` URL and `loadKey('astrid')` call were hardcoded to astrid. Not in renamegoose scope. **Must grep `/home/deploy/agents/` for old name after every rename.**
- **`publish-homepage.mjs` HTML content** had 3 hardcoded "Astrid" strings (goose-card name, Checky desc "escalates to Astrid", step-desc). **Added to renamegoose step 10, and verify with grep after.**
- **`haitje/skills/*.js`** — references to "Astrid" in comments/logs and the agent name list in `check.js`. Not automation targets. **Always run the full grep sweep including `/home/deploy/systemsetup/scripts/haitje/`.**
- **`agents/agents.json` Checky about field** — "escalates to Astrid" not caught by renamegoose. **Now fixed via renamegoose step 5 (agents.json), but check prose fields too.**
- **`newapp/src/hooks/useBuild.ts`** — `addLog('astrid', ...)` calls were missed by the initial sed (only replaced quoted `'astrid'` in type positions). **The addLog calls needed a second pass. Grep carefully for any string literal usage beyond type annotations.**
- **`~/.claude/CLAUDE.md` persona definition** — entire file was Astrid-centric (title, intro para, git branch convention `astrid/`, TODO section `@Astrid`, cleanup section heading). **Not automatable (gitignored). Must be done manually every time the primary orchestrator is renamed.** Many sed patterns fail due to special chars — use Edit tool for each line.
- **`agents/<newname>/tile.html`** — renamegoose renames the file but HTML content (data-agent, alt, h3, img src) still used old name. **Manual edit still required. This is documented as a permanent manual step.**
- **`obsidian/setup.sh`** — contains hardcoded Astrid entries. Low priority (setup-only script), left as historical reference.

## Lessons learned from Communi → Commy (2026-06-04)

- `.claude/agents/<name>.md` not renamed → tile showed empty description. **Fixed in renamegoose step 11b.**
- `agents/designy/designy.md` color table, `generate-agents-html.py`, `publish-agent-pages.mjs`, `pages/homepage_base.html` — all missed. **Added to renamegoose steps 10b–10e.**
- `agents/commy/commy.md` body text + `tile.html` internal HTML still said "Communi" — renamegoose renames files but doesn't rewrite prose content. **Manual step.**
- **Agent nsite page** (what opens when clicking the agent card on homepage) still showed "Communi" — `publish-agent-pages.mjs` generates and uploads the HTML page from `.claude/agents/<name>.md`. Must be re-run after rename. **Fixed in renamegoose step 13b.**
- **App source files** (`newapp`, `gooseprogrammer`, `swarm`) had hardcoded `'communi'` agent names — not caught by renamegoose (separate repos). **Always run the grep sweep across apps after rename.**
- When committing app repos: always `git add <specific files>`, never `git add -A` — may pull in unrelated staged files (learned from swarm commit).
