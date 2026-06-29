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

Its defining feature: **every Company and Contact record is its own
self-sovereign Nostr identity**. Records start custodial (the CRM holds the
key), can be transferred to the real person, or linked to a person's existing
npub — so customers can manage their own data and exercise their AVG/GDPR rights
(erase, hide, withdraw consent). Read the "self-sovereign records" architecture
section below in full before Phase 1.

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

### Config, sovereignty & view kinds
- **30951 — Schema/config** (`d:"nostrm-schema"`): editable labels for Company
  key1-4, the relation vocabulary, and the Details field list.
- **30952 — Saved view** (per-user filters/layouts). Later phase.
- **30960 — Consent/grant** (signed by the data subject): controller pubkey,
  purpose, scope, status(granted/withdrawn), ts. GDPR lawful-basis audit trail.
- **30961 — Key-vault** (authored by controller, NIP-44-encrypted to the
  controller key): holds a record's custodial nsec, `d = <record-pubkey>`.
  Deleted (NIP-09) on key transfer.

### CRITICAL: self-sovereign records & GDPR/AVG (read carefully)

Every **Company and Contact record IS its own Nostr identity (keypair)** — not
just data the CRM owner authors. Control of a record can move to the real
person; the data subject holds the keys to their own personal data. This is the
defining feature and the AVG-compliance backbone. Two data layers per record:

- **Subject layer (PII)** — name, address, phone, email, socials. Authored by
  the **record's own key**, NIP-44-encrypted to the controller so the company
  can read it. Kinds 30900/30901 + person-Details (30907). The subject controls
  it: can erase (NIP-09) or hide (stop re-encrypting to controller).
- **Controller layer (business)** — edges (30950), internal notes, History
  (30905), key1-4 business fields, classifications. Authored by the **CRM/company
  key**, referencing the record by pubkey. The company's own legitimate record.

Details follow their subject: a person's phone/email = subject layer; a
product's price = controller layer.

**Edge addressing for keyed records:** reference Company/Contact by their
**pubkey** via `["p",<pubkey>,"<relay>","<role>"]` + `["k","30901"]`, NOT by an
`a`-coordinate. Non-keyed entities (Document/Agenda/Todo/History/Product/
controller-Details) keep the `a`-coordinate form above.

**Custody lifecycle** (track as a status field on the controller-layer record):
`custodial` (CRM generated + holds encrypted nsec in vault) → `linked` (person
brought their own npub; never custodial) → `transferred` (nsec handed over, CRM
destroyed its copy) → `withdrawn` (subject erased/hid PII).

**Key vault:** store each custodial nsec as a 30961 event, NIP-44-encrypted to
the controller key, on the private relay. Never log/commit/print an nsec; it
exists in plaintext only transiently in memory during a transfer.

**Transfer ceremony (custodial → person):** person supplies a destination
pubkey (or scans a claim QR) → CRM sends the record nsec via a NIP-17
gift-wrapped DM, or as a NIP-49 `ncryptsec` with an out-of-band passphrase →
person imports → CRM NIP-09-deletes the vault event and sets status=transferred.

**Link existing (receive a person's identity):** person shares npub/NIP-05 →
challenge them to sign a nonce (proves control) → link the record to that
pubkey, subscribe to their PII, no custody.

**GDPR mechanisms:** erasure = subject NIP-09-deletes their PII (relay drops
it); restrict/hide = subject stops encrypting new PII to controller + deletes
old; consent = 30960 events; portability = subject already holds data under
their own key. **Honest caveat:** Nostr deletes are best-effort — data already
copied by third parties can't be force-forgotten. Document this residual risk;
never promise "guaranteed deletion."

**Relay access model:** the private nostrm relay grants each record pubkey
write+delete rights (NIP-42 allowlist managed by the CRM), read restricted to
controller + the subject. Records publish their encrypted PII there; withdrawal
= they delete it there.

### Privacy & signing
- Access-restricted relay via **NIP-42** allowlist (only CRM + record pubkeys
  can read/write).
- **NIP-44 encryption of PII (subject → controller) is core, not optional** —
  it lands with the keyed records (see phase plan), superseding the old
  "encryption-at-rest as a late phase" idea.
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

### Phase 1 — Companies & Contacts (KEYED entities + hierarchy)
- **Every Company/Contact record gets its own keypair at creation** (this avoids
  an authorship refactor later — do it now even though the full custody/transfer
  machinery comes in Phase 4). Generate a keypair per record; for now the CRM
  holds the nsec custodially (a simple in-memory/encrypted store is fine this
  phase — the proper 30961 vault lands in Phase 4).
- A small `nostrm-core.js` module: create/read/update/delete the subject-layer
  PII events (kinds 30900/30901) **signed by the record's own key**; generate
  `d` ids (`d:"self"`), publish, subscribe, maintain the in-memory index.
- A `nostrm-controller.js` boundary: controller-layer data (status field,
  later edges/history) signed by the CRM key. Keep the two layers separate from
  the start so the GDPR model in Phase 4 slots in cleanly.
- CRUD forms for Company (all fields incl. key1-4) and Contact.
- Build sections 1, 2, 4, 5: hierarchy tree (companies; contacts flat for now),
  name header, address block, key fields. Editing a record republishes the
  replaceable event under the record's key.
- **Demo:** add a company and a contact, edit them, reload — data persists; each
  record shows its own npub and custody status `custodial`.
- **Commit:** `nostrm: phase 1 — keyed Company & Contact CRUD + sections 1,2,4,5`

### Phase 2 — Edges (the graph)
- `nostrm-links.js`: create/delete Link events (30950) with rel/inv/dir/k tags;
  query edges by endpoint; resolve neighbors. For keyed records (Company/
  Contact) reference endpoints by **pubkey** (`p`-tag + `k`-tag); for non-keyed
  records use the `a`-coordinate. Edges are controller-layer (signed by CRM key).
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

### Phase 4 — Sovereignty & AVG/GDPR (the crucial layer)
- **Key vault (30961):** move custodial nsecs into NIP-44-encrypted vault events
  (encrypted to the controller key), `d=<record-pubkey>`, on the private relay.
  Replace the Phase-1 interim store. Never log/print/commit an nsec.
- **PII encryption:** encrypt subject-layer `content` (30900/30901 +
  person-Details) with NIP-44 from the record's key to the controller key.
  Keep only `name`/`t`/`k` tags plaintext for filtering. Migrate Phase-1 records.
- **Consent events (30960):** a subject-signed grant (controller, purpose,
  scope, status, ts) recorded on link/creation; a withdrawal flow that emits a
  signed withdrawal + deletes the relevant PII. Show consent status per record.
- **Transfer ceremony (custodial → person):** UI to hand a record's key to the
  real person via NIP-17 gift-wrapped DM or NIP-49 `ncryptsec`; on success
  NIP-09-delete the vault event and set status=`transferred`.
- **Link existing:** accept a person's npub/NIP-05, challenge-sign a nonce to
  verify control, link the record (status=`linked`), no custody.
- **Right to erasure / hide:** a record (or its owner) can NIP-09-delete its PII
  (status=`withdrawn`); the view degrades to the controller-layer minimal record.
- Show the **custody status** (`custodial` / `linked` / `transferred` /
  `withdrawn`) on each Company/Contact.
- **Demo:** create a custodial contact → record a consent → transfer the key to
  a second test npub (vault event deleted) → from that npub delete the PII →
  CRM shows it withdrawn but keeps its own History.
- **Commit:** `nostrm: phase 4 — key vault, PII encryption, consent, transfer & erasure (AVG)`

### Phase 5 — Config, search & multi-user
- Schema/config event (30951): editable labels for key1-4, editable relation
  vocabulary, editable Details field list — UI applies them everywhere.
- Local full-text search across the in-memory index (decrypted client-side).
  Quick filter in the hierarchy.
- IndexedDB cache for fast cold start; reconcile with relay on load.
- Multi-user: several controller pubkeys on the NIP-42 allowlist; `author` is
  the audit actor in History; shared-CRM-key handling documented.
- **Commit:** `nostrm: phase 5 — schema config (30951) + search + cache + multi-user`

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
