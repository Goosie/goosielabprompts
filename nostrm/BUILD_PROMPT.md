# NostrM — Build Prompt for `newapp nostrm`

> **How to use:** run `newapp nostrm` on the server, then paste the block below
> (everything between the `=== PROMPT START ===` and `=== PROMPT END ===`
> markers) as the first message to the Claude Code session.
>
> The prompt is self-contained: it carries the full spec so the fresh session
> needs no other files. The canonical design lives in
> `goosielabprompts/nostrm/DESIGN.md` for reference, but the build session does
> not depend on it.

---

=== PROMPT START ===

You are building **NostrM**, a CRM whose entire dataset lives as Nostr events
on a dedicated, access-restricted relay (created via the LNbits *Nostr Relay*
extension). No SQL, no central DB — the relay is the backend.

Read `/var/www/goosielabs/apps/CLAUDE.md` and the root `CLAUDE.md` before
writing code. Honor the lab conventions:
- **English everywhere** — code, comments, UI strings, commit messages.
- **Standalone & lean** — everything this app needs lives in
  `apps/nostrm/`; no references up to the root. Minimal dependencies
  (`nostr-tools` for events/NIP-44/NIP-42; a tiny build setup or none).
- **Memory-safe** — server has ~1.9 GiB RAM. Use
  `NODE_OPTIONS=--max-old-space-size=1024` and
  `npm install --no-audit --no-fund --prefer-offline`. Prefer a static SPA
  with no heavy bundler.
- **Commit per phase** — one logical commit at the end of each phase below,
  with a clear message. Do not bundle phases.
- **Lightning payment UX**, **datetime-local `.slice(0,16)`**, and other
  patterns from CLAUDE.md apply where relevant.

This is a LARGE project. Work the phased plan below **in order**. At the end of
each phase: build, verify it works in the browser at
`https://goosielabs.com/apps/nostrm`, commit, then **STOP and report** what you
built with a 1-line "how to test" so Perry can review before you continue. Do
not run ahead to the next phase without his go-ahead.

---

## Architecture (read fully before Phase 0)

**Everything is a Nostr event.** Records are addressable (parameterized
replaceable, kind 30000–39999) so they can be edited/replaced via a stable
`d` tag. Relationships are **first-class edge events**, not embedded tags —
this is the core design decision and enables n→n between all categories,
self-relations, and typed/labelled links.

### Entity kinds (8 categories)

| Kind | Category | `content` fields (JSON) |
|------|----------|-------------------------|
| 30900 | Company | companyname, address1-3, state, zip, city, country, key1, key2, key3, key4 |
| 30901 | Contact | firstname, midname, lastname, address1-3, state, zip, country |
| 30902 | Document | title, kind, url, mime, hash, body |
| 30903 | Agenda | title, start(unix), end(unix), allDay, location, notes |
| 30904 | Todo | title, status(open/doing/done/cancelled), due(unix), priority, notes |
| 30905 | History | type(call/email/meeting/note/change/payment), at(unix), summary, body, actor |
| 30906 | Product | name, sku, description, unit, active |
| 30907 | Details | phone1-4, email, twitter, linkedin, website, price, currency, custom{} |

Each entity event has tags: `["d","<prefix>_<uuid>"]`, a human `["name",...]`
or `["title",...]` for cheap sorting, and `["t","<category>"]`. Keep sensitive
data OUT of tags (only non-sensitive name/title/type belong there).

`d`-prefixes: `cmp_`, `con_`, `doc_`, `agn_`, `tod_`, `his_`, `prd_`, `det_`.

### Edge kind (relationships)

**Kind 30950 — Link.** Tags:
```
["d","lnk_<uuid>"]
["a","30900:<pubkey>:cmp_acme","<relay>","from"]   // endpoint A coordinate
["a","30901:<pubkey>:con_piet","<relay>","to"]     // endpoint B coordinate
["rel","employee_of"]        // relationship label A->B
["inv","employer_of"]        // inverse label B->A (optional)
["dir","directed"]           // "directed" | "mutual"
["k","30900"] ["k","30901"]  // flat kind tags of each endpoint, for fast filtering
["t","link"]
```
`content` (optional edge metadata): `{ role, since, weight, notes }`.

Endpoints are **addressable coordinates** (`kind:pubkey:d`) so an edge always
resolves to the latest version of a record. `dir:"mutual"` for symmetric
relations (spouse, colleague) — one edge suffices. Self-relations (company↔company,
contact↔contact, product↔product) use the same mechanism.

Recommended relation vocabulary (free text, but suggest these in the UI):
- Company↔Contact: employee_of(employer_of), ceo_of, owner_of, board_member_of
- Contact↔Contact: spouse(mutual), parent_of(child_of), colleague(mutual), knows(mutual)
- Company↔Company: supplier_of(customer_of), partner_of(mutual), subsidiary_of(parent_company_of), competitor_of(mutual)
- Product↔Product: part_of(contains), variant_of, accessory_of, bundle_of
- Document↔*: attached_to, signed_by, concerns, version_of
- Agenda↔*: with, about, organized_by · Todo↔*: for, assigned_to, blocks
- History↔*: logged_for, by · Details↔*: details_of

### Config & view kinds
- **30951 — Schema/config** (`d:"nostrm-schema"`): editable labels for Company
  key1-4, the relation vocabulary, and the Details field list.
- **30952 — Saved view** (per-user filters/layouts). Later phase.

### Privacy
- v1: access-restricted relay via **NIP-42** allowlist (only CRM pubkeys can
  read/write). Content plaintext for now.
- Phase 6 adds **NIP-44 encryption-at-rest** on the `content` field.
- Signing via **NIP-07** browser extension (Alby/nos2x) for the user, with an
  app nsec in `apps/nostrm/.env` only if a headless task needs it (never in
  chat/commits/code — per CLAUDE.md).

---

## The screen — 6 sections

```
+------------------+--------------------------------------------------+
| (1) HIERARCHY    | (2) NAME                  (3) PRIMARY CONTACT     |
| tree:            |   Acme Corp                 phone1 / phone2 / email
|  > Company       +------------------------+-------------------------+
|    - Contact     | (4) ADDRESS            | (5) KEY FIELDS (key1-4) |
|    - Contact     |   address block        |   labelled, editable    |
|  > Company       +------------------------+-------------------------+
|                  | (6) LINKED CATEGORIES (tabs/columns)             |
| [+company]       |  Todos | Agenda | Docs | History | Products       |
| [+contact]       |  each shows edge-linked items + relation label   |
|                  |  + link existing / + new-and-link (pick rel type) |
+------------------+--------------------------------------------------+
```

1. **Hierarchy (left):** tree of Companies with their Contacts (via
   `employee_of` edges). A contact may appear under several companies (n→n) —
   that is correct. Click selects an entity.
2. **Name (top):** company name if a company is selected, else the contact's
   full name.
3. **Primary contact (top-right):** phone1, phone2, email from the entity's
   primary Details bag.
4. **Address (under name):** address1-3, zip, city, state, country.
5. **Key fields (beside address):** key1-4 with their configurable labels.
6. **Linked categories (bottom):** columns/tabs for Todos, Agenda, Documents,
   History, Products (+ Details). Each lists edge-linked items with their
   relation label, plus buttons to link an existing item or create+link a new
   one (choosing the relation type).

Interaction: select entity -> fetch all edges where `#a` = its coordinate ->
resolve neighbors -> fill sections 2-6. Clicking a linked item navigates to it
(walk the graph). Keep an in-memory graph index (entities + edges), kept live
via an open subscription; cache in IndexedDB for speed.

---

## PHASED BUILD PLAN

Each phase = build -> verify in browser -> one commit -> STOP & report.

### Phase 0 — Relay + skeleton
- Enable the LNbits **Nostr Relay** extension, create a relay named `nostrm`,
  note the `wss://.../nostrrelay/<id>` URL. Put it in `apps/nostrm/.env` as
  `VITE_RELAY_URL` (or a `config.js`), not hardcoded.
- Configure NIP-42 so only the CRM pubkey(s) may read/write.
- Scaffold the static SPA in `apps/nostrm/` (lean: vanilla or a tiny framework,
  `nostr-tools`). NIP-07 login (connect Alby/nos2x), show the logged-in npub,
  connect to the relay, show connection status.
- **Demo:** open the app, connect extension, see "connected to nostrm relay".
- **Commit:** `nostrm: phase 0 — relay config + SPA skeleton + NIP-07 login`

### Phase 1 — Companies & Contacts (entities + hierarchy)
- A small `nostrm-core.js` module: create/read/update/delete addressable
  events (kinds 30900/30901), generate `d` ids, publish, subscribe, maintain
  the in-memory index.
- CRUD forms for Company (all fields incl. key1-4) and Contact.
- Build sections 1, 2, 4, 5: hierarchy tree (companies; contacts nested once
  edges exist — for now flat lists are fine), name header, address block, key
  fields. Editing a record republishes the replaceable event.
- **Demo:** add a company and a contact, edit them, reload — data persists from
  the relay.
- **Commit:** `nostrm: phase 1 — Company & Contact CRUD + sections 1,2,4,5`

### Phase 2 — Edges (the graph)
- `nostrm-links.js`: create/delete Link events (30950) with rel/inv/dir/k tags;
  query edges by endpoint coordinate; resolve neighbors.
- Relation-type picker with the recommended vocabulary (company↔contact,
  contact↔contact, company↔company), supporting directed + mutual and
  self-relations.
- Wire the hierarchy tree to `employee_of` edges (contacts nest under their
  companies). "Link existing" UI between two selected entities.
- Cascade: deleting an entity (NIP-09) also removes its edges; hide dangling
  edges.
- **Demo:** link Piet as employee_of Acme; mark Piet spouse_of Carla; mark
  Globex supplier_of Acme — all visible and navigable.
- **Commit:** `nostrm: phase 2 — first-class Link edges + relation picker`

### Phase 3 — Remaining categories + section 6
- CRUD for Documents (30902 — store url+hash+note for now; no upload yet),
  Agenda (30903; datetime-local using `.slice(0,16)`), Todo (30904), Product
  (30906; product↔product part_of links), History (30905; append-only),
  Details (30907; multiple bags per entity, mark one primary).
- Section 6: columns/tabs showing edge-linked Todos/Agenda/Docs/History/
  Products for the selected entity, each with its relation label, plus
  link-existing and create-and-link.
- Section 3 reads phone1/phone2/email from the primary Details bag.
- **Demo:** attach a document + a todo + an agenda item + a history note to
  Acme; see them in section 6; primary Details phone/email show top-right.
- **Commit:** `nostrm: phase 3 — Documents/Agenda/Todo/Product/History/Details + section 6`

### Phase 4 — Config & search
- Schema/config event (30951): editable labels for key1-4, editable relation
  vocabulary, editable Details field list — UI applies them everywhere.
- Local full-text search across the in-memory index (names, fields). Quick
  filter in the hierarchy.
- IndexedDB cache for fast cold start; reconcile with relay on load.
- **Commit:** `nostrm: phase 4 — schema config (30951) + local search + cache`

### Phase 5 — Privacy & multi-user
- NIP-44 encryption-at-rest for `content` (encrypt on publish, decrypt on
  load); keep name/title/type tags plaintext for filtering. Migrate existing
  records.
- Multi-user: support several pubkeys on the NIP-42 allowlist; `author` becomes
  the audit actor in History; shared CRM key handling documented.
- **Commit:** `nostrm: phase 5 — NIP-44 encryption-at-rest + multi-user allowlist`

### Phase 6 — Extras (only if asked)
- NIP-52 agenda export; Blossom upload for Documents; Lightning (zaps on
  contacts, paid documents) using the CLAUDE.md LNbits WebSocket pattern;
  CSV/JSON import/export; saved views (30952).

---

## Working rules for this build
- After each phase: `npm run build` (memory-safe flags), confirm the static
  files serve under `/apps/nostrm`, no Nginx changes needed.
- Keep functions small and the data layer (`nostrm-core.js` / `nostrm-links.js`)
  separate from the UI so the model is testable.
- Never output or commit nsec/private keys. App secrets go in
  `apps/nostrm/.env` only.
- If a design decision is genuinely ambiguous (e.g. relay NIP-42 specifics in
  LNbits, or how primary-Details should be chosen), ask Perry rather than
  guessing.
- Update `apps/nostrm/CLAUDE.md` (create it) with the kinds table, relay URL
  location, and "how to run" as you go, so the app is self-documenting.

Start with Phase 0. Build it, verify, commit, then stop and report.

=== PROMPT END ===
