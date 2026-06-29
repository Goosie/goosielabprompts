# 🪿 NostrM — een CRM op Nostr

> **Status:** Design / RFC — nog niet gebouwd
> **Auteur:** CRM-architectuur uitwerking voor Perry
> **Datum:** 2026-06-29
> **Kern in één zin:** een graph-CRM waarvan álle data als Nostr-events op een
> eigen, afgeschermde relay leeft (aangemaakt via de LNbits *Nostr Relay*
> extensie), met 8 entiteitscategorieën die onderling n→n en getypeerd
> aan elkaar gelinkt zijn.

---

## 1. Het idee in het kort

NostrM is een persoonlijk/team-CRM zonder centrale database. Er is geen
SQL-server, geen SaaS-lock-in. In plaats daarvan:

- Elke **record** (een bedrijf, een contact, een document…) is een
  **addressable Nostr-event** met een stabiel `d`-id, zodat je het kunt
  bewerken en verwijderen.
- Elke **relatie** tussen twee records is een **eigen event** (een edge in een
  graph), met een **relatietype** erin. Dit maakt n→n, zelf-relaties
  (bedrijf↔bedrijf, contact↔contact, product↔product) en rijke labels
  ("man van", "leverancier van", "werkt bij") mogelijk.
- Alles staat op een **eigen relay** die we via LNbits aanzetten. Lezen/schrijven
  is afgeschermd met NIP-42 (alleen toegestane pubkeys).

Het resultaat: jouw CRM-data is van jou, draagbaar (elke Nostr-client kan er in
principe bij), en je kunt er Lightning/zaps, badges en andere Nostr-bouwstenen
moeiteloos aan koppelen.

---

## 2. De 8 categorieën (entiteiten)

| # | Categorie | Wat het is | Kind (voorstel) | Replaceable? |
|---|-----------|-----------|-----------------|--------------|
| 1 | **Companies** | Bedrijven / organisaties | `30900` | ja (addressable) |
| 2 | **Contacts** | Personen | `30901` | ja |
| 3 | **Documents** | Bestanden / notities / contracten | `30902` | ja |
| 4 | **Agenda** | Afspraken / kalender-items | `30903` | ja |
| 5 | **Todo** | Taken / acties | `30904` | ja |
| 6 | **History** | Interactie-logboek (append-only) | `30905` | ja, maar write-once per conventie |
| 7 | **Products** | Producten / diensten / onderdelen | `30906` | ja |
| 8 | **Details** | Flexibele attribuut-bagjes (telefoon, e-mail, socials, prijs…) | `30907` | ja |

Alle entiteiten gebruiken de **parameterized replaceable** range
(`30000–39999` uit NIP-01). Het `d`-tag is de primaire sleutel; een nieuwe
versie met hetzelfde `d` vervangt de oude → gratis "edit record".

> **Waarom geen losse velden in tags maar in `content`?** Tags zijn
> relay-doorzoekbaar maar lekken data naar wie de relay leest. We houden
> alleen een paar handige zoek-/sorteervelden in tags (`name`, `t`) en zetten
> de inhoud in `content` (optioneel NIP-44-versleuteld — zie §7).

### 2.1 Velddefinities per categorie

#### 1. Company (`kind 30900`)
```jsonc
{
  "kind": 30900,
  "tags": [
    ["d", "cmp_<uuid>"],          // stabiele id
    ["name", "Acme Corp"],         // zoek-/sorteerveld (mag in tag)
    ["t", "company"]
  ],
  "content": {                      // JSON, optioneel NIP-44-encrypted
    "companyname": "Acme Corp",
    "address1": "", "address2": "", "address3": "",
    "state": "", "zip": "", "city": "", "country": "",
    "key1": "", "key2": "", "key3": "", "key4": ""   // vrij programmeerbare velden
  }
}
```
De **key1–key4** zijn vrij invulbaar/programmeerbaar per CRM (bijv. key1 =
"BTW-nummer", key2 = "Segment", key3 = "Account owner", key4 = "KvK"). De
labels van die velden zijn zelf configureerbaar (zie §6, schema-config event).

#### 2. Contact (`kind 30901`)
```jsonc
{
  "content": {
    "firstname": "", "midname": "", "lastname": "",
    "address1": "", "address2": "", "address3": "",
    "state": "", "zip": "", "city": "", "country": ""
  }
}
```

#### 3. Document (`kind 30902`)
```jsonc
{
  "content": {
    "title": "",
    "kind": "contract|note|invoice|file|...",
    "url": "",            // Blossom/nostr.build/IPFS hash of externe URL
    "mime": "application/pdf",
    "hash": "",           // sha256 voor integriteit
    "body": ""            // optioneel: inline notitie/markdown
  }
}
```

#### 4. Agenda (`kind 30903`)
Eigen kind, maar bewust **compatibel met NIP-52** (calendar events
`31922/31923`) zodat externe agenda-clients het kunnen tonen.
```jsonc
{
  "content": {
    "title": "", "start": "<unix>", "end": "<unix>",
    "allDay": false, "location": "", "notes": ""
  }
}
```
> Alternatief: gebruik direct NIP-52 kinds en behandel ze als "Agenda".
> Aanbeveling: eigen `30903` voor controle, met een NIP-52-export.

#### 5. Todo (`kind 30904`)
```jsonc
{
  "content": {
    "title": "", "status": "open|doing|done|cancelled",
    "due": "<unix>", "priority": "low|med|high", "notes": ""
  }
}
```

#### 6. History (`kind 30905`) — append-only logboek
```jsonc
{
  "content": {
    "type": "call|email|meeting|note|change|payment",
    "at": "<unix>", "summary": "", "body": "",
    "actor": "<pubkey die de actie deed>"
  }
}
```
History wordt **niet bewerkt** (per conventie write-once); correcties =
nieuwe entry. Edges koppelen een history-entry aan het bedrijf/contact/etc.
waar het over gaat.

#### 7. Product (`kind 30906`)
```jsonc
{
  "content": {
    "name": "", "sku": "", "description": "",
    "unit": "", "active": true
  }
}
```
Prijs/voorraad/specs horen in **Details** (zodat een product meerdere
prijzen/varianten kan hebben), of inline als je 1-op-1 wilt.

#### 8. Details (`kind 30907`) — flexibele attribuut-bag
Dé generieke uitbreiding die aan álle andere categorieën hangt.
```jsonc
{
  "tags": [["d","det_<uuid>"], ["t","details"], ["label","Hoofdkantoor"]],
  "content": {
    "phone1": "", "phone2": "", "phone3": "", "phone4": "",
    "email": "",
    "twitter": "", "linkedin": "", "website": "",
    "price": "", "currency": "EUR",
    "custom": { "<vrij>": "<waarde>" }   // open key/value
  }
}
```
Eén entiteit kan **meerdere** Details-bagjes hebben (bijv. "Facturatie",
"Bezoekadres", "Support") en een Detail kan in theorie gedeeld worden tussen
entiteiten. Telefoon/e-mail die rechtsboven in het scherm verschijnen (§5)
komen uit het *primaire* Details-bagje van de geselecteerde entiteit.

---

## 3. Het relatiemodel — de kern

> **Ontwerpkeuze:** relaties zijn **first-class events** (graph-edges), niet
> ingebedde tags. Dit is de belangrijkste architectuurbeslissing.

### 3.1 Waarom edges-als-events?

| Eis | Edge-als-event | Tags-in-entiteit |
|-----|----------------|------------------|
| n→n tussen álle categorieën | ✅ triviaal | ⚠️ dubbel onderhoud |
| Relatie heeft eigen **type/metadata** | ✅ ("man van", sinds, rol) | ❌ moeilijk |
| Zelf-relaties (bedrijf↔bedrijf) | ✅ | ⚠️ verwarrend |
| Eén kant aanpassen/verwijderen | ✅ NIP-09 delete van 1 event | ❌ beide records bewerken |
| Richting + inverse label | ✅ | ❌ |

### 3.2 Het Link-event (`kind 30950`)

```jsonc
{
  "kind": 30950,
  "tags": [
    ["d", "lnk_<uuid>"],
    ["a", "30900:<pubkey>:cmp_acme", "<relay>", "from"],   // endpoint A
    ["a", "30901:<pubkey>:con_piet", "<relay>", "to"],     // endpoint B
    ["rel", "employee_of"],          // relatietype A→B
    ["inv", "employer_of"],          // inverse label B→A (optioneel)
    ["dir", "directed"],             // "directed" of "mutual"
    ["t", "link"],
    ["k", "30900"], ["k", "30901"]   // platte kind-tags voor snelle filtering
  ],
  "content": {                        // optionele edge-metadata
    "role": "CFO", "since": "2021-04-01", "weight": 1, "notes": ""
  }
}
```

Belangrijke punten:
- De twee `a`-tags verwijzen naar **addressable coordinates**
  (`kind:pubkey:d`). Daarmee wijst een edge altijd naar de *laatste versie*
  van een record (geen kapotte verwijzing na een edit).
- `rel` = het hoofdlabel; `inv` = hoe je het van de andere kant noemt
  ("leverancier van" ↔ "klant van").
- `dir: "mutual"` voor symmetrische relaties (echtgenoten, collega's): één
  edge volstaat, beide kanten gebruiken `rel`.
- De extra `k`-tags (kind van elk endpoint) maken queries als "geef alle
  links tussen een company en een contact" snel zonder de `a`-waarde te
  hoeven parsen.

### 3.3 Voorgestelde relatie-vocabulaire (uitbreidbaar)

Vrij tekstveld, maar met een aanbevolen woordenlijst per categorie-paar voor
consistentie en goede UI-suggesties:

| Paar | Voorbeelden van `rel` (inverse) |
|------|-------------------------------|
| Company ↔ Contact | `employee_of` (employer_of), `ceo_of`, `owner_of`, `board_member_of`, `decision_maker_at` |
| Contact ↔ Contact | `spouse` *(mutual)*, `parent_of` (child_of), `colleague` *(mutual)*, `assistant_of`, `knows` *(mutual)* |
| Company ↔ Company | `supplier_of` (customer_of), `partner_of` *(mutual)*, `subsidiary_of` (parent_company_of), `competitor_of` *(mutual)* |
| Product ↔ Product | `part_of` (contains), `variant_of`, `accessory_of`, `bundle_of` |
| Document ↔ * | `attached_to`, `signed_by`, `concerns`, `version_of` |
| Agenda ↔ * | `with`, `about`, `organized_by` |
| Todo ↔ * | `for`, `assigned_to`, `blocks`, `follows_up` |
| History ↔ * | `logged_for`, `by` |
| Details ↔ * | `details_of` |

De woordenlijst zelf staat in een config-event (§6) zodat hij per CRM aan te
passen is.

### 3.4 Een voorbeeld-graph

```
        supplier_of
 Globex ───────────────▶ Acme Corp ◀── employee_of ── Piet ── spouse ── Carla
                            │                            │
                      attached_to                    details_of
                            │                            │
                     [Document: NDA]              [Details: 06-..., piet@acme.nl]
```

Eén query op "alle edges met `a` = Acme" levert het hele sterretje rond Acme:
contacten, leveranciers, documenten, agenda, todo's, history.

---

## 4. Data-architectuur & relay

### 4.1 LNbits Nostr Relay extensie

1. In LNbits → **Extensions** → *Nostr Relay* aanzetten.
2. Maak een nieuwe relay aan, bijv. `nostrm`. Je krijgt een
   `wss://…/nostrrelay/<relay-id>` endpoint.
3. Configureer toegang (zie §7) zodat alleen de CRM-pubkeys mogen
   lezen/schrijven.
4. NostrM-app verbindt uitsluitend met deze relay voor CRM-data.

> Voordeel: de relay-lifecycle hangt aan LNbits (al draaiend op
> `lnbits.goosielabs.com`), en je krijgt later Lightning-integratie cadeau
> (zaps op contacten, betaalde documenten, etc.).

### 4.2 Kinds-overzicht (reservering)

| Range | Gebruik |
|-------|---------|
| `30900–30907` | De 8 entiteitscategorieën |
| `30950` | Link/edge events |
| `30951` | Schema-/config event (veldlabels, vocabulaire, key-field namen) |
| `30952` | Saved views / filters (per gebruiker) |
| `5` (NIP-09) | Deletes (entiteit of edge intrekken) |

Allemaal binnen de addressable range zodat edits/replace werken.

### 4.3 Query-patronen

| Vraag | Filter |
|-------|--------|
| Alle bedrijven | `{ kinds:[30900], authors:[crmKeys] }` |
| Eén bedrijf | `{ kinds:[30900], "#d":["cmp_acme"] }` |
| Alle links van Acme | `{ kinds:[30950], "#a":["30900:<pk>:cmp_acme"] }` |
| Alle contacten van Acme | links ophalen → endpoints met `k=30901` resolven |
| Alle todo's gekoppeld aan X | links met `a=X` en `k=30904` → todo-events ophalen |
| Hiërarchie-boom (links) | bedrijven → per bedrijf de `employee_of`-links → contacten |

De client bouwt lokaal een **in-memory graph index** (entiteiten + edges) en
houdt 'm live via een open subscription. Voor grotere datasets: lazy-load per
geselecteerde entiteit (haal pas edges/buren op bij selectie).

### 4.4 Referentiële integriteit

Nostr kent geen foreign keys. Strategie:
- Edges wijzen naar `kind:pubkey:d` (addressable) → overleeft edits.
- Bij **verwijderen** van een entiteit: publiceer NIP-09 delete én ruim de
  bijbehorende edges op (client-side cascade: zoek edges met dat endpoint,
  delete ze). Een achtergrond-"garbage collector" kan wees-edges opruimen.
- De app behandelt een edge naar een niet-bestaand/ingetrokken record als
  "dangling" en verbergt 'm (en kan 'm opruimen).

---

## 5. UI — het 6-secties scherm

```
┌────────────────────┬─────────────────────────────────────────────────────────┐
│  (1) HIËRARCHIE     │  (2) NAAM                      (3) PRIMAIR CONTACT        │
│                     │  Acme Corp                     ☎ +31 6 12345678          │
│  ▾ Acme Corp        │  (bedrijfsnaam als company     ☎ +31 20 9876543          │
│     • Piet  (CFO)   │   geselecteerd, anders de      ✉ piet@acme.nl            │
│     • Carla         │   contactpersoon)              [bewerk primair Detail]   │
│  ▾ Globex           ├──────────────────────────────┬──────────────────────────┤
│     • John          │  (4) ADRES                    │  (5) KEY-VELDEN          │
│  ▸ Initech          │  Main Street 1                │  key1: BTW NL0000        │
│                     │  Unit 4                       │  key2: Segment = A       │
│  [+ bedrijf]        │  1234 AB  Amsterdam           │  key3: Owner = Perry     │
│  [+ contact]        │  Nederland                    │  key4: KvK 12345678      │
│                     ├──────────────────────────────┴──────────────────────────┤
│                     │  (6) GEKOPPELDE CATEGORIEËN  (tabs of kolommen)          │
│                     │  ┌─Todos──┐ ┌─Agenda─┐ ┌─Docs──┐ ┌─History┐ ┌─Products┐ │
│                     │  │ ☐ Bel  │ │ 3 jul  │ │ NDA   │ │ call   │ │ Widget  │ │
│                     │  │ ☐ Mail │ │ 9 jul  │ │ Offer │ │ email  │ │ Gadget  │ │
│                     │  └────────┘ └────────┘ └───────┘ └────────┘ └─────────┘ │
│                     │  + relateer bestaand / + nieuw, met keuze van relatietype │
└────────────────────┴─────────────────────────────────────────────────────────┘
```

**Secties:**
1. **Hiërarchie (links, verticaal):** boom van Companies met daaronder hun
   Contacts (via `employee_of`-edges). Klik = selecteer. Een contact kan onder
   meerdere bedrijven verschijnen (want n→n) — dat is een feature, geen bug.
2. **Naam (rechtsboven):** bedrijfsnaam als een company geselecteerd is, anders
   de contactnaam (firstname + midname + lastname).
3. **Primair contact (uiterst rechtsboven):** phone1, phone2, email uit het
   primaire **Details**-bagje.
4. **Adresblok (onder naam):** address1–3, zip, city, state, country.
5. **Key-velden (naast adres):** de 4 vrij programmeerbare velden, met hun
   configureerbare labels.
6. **Gekoppelde categorieën (onder):** kolommen/tabs voor Todos, Agenda,
   Documents, History, Products (en losse Details). Elke kolom toont de via
   edges gekoppelde items, met het relatietype erbij, en knoppen om bestaande
   items te koppelen of nieuwe te maken + meteen te linken.

**Interactie-principe:** selecteer een entiteit → de app haalt alle edges van
die entiteit op → vult secties 2–6. Een klik op een gekoppeld item navigeert
daarheen (de graph "wandelen").

---

## 6. Configureerbaarheid (schema-event `30951`)

Omdat key1–key4 en de relatie-vocabulaire "programmeerbaar" moeten zijn, leeft
de configuratie zelf óók als Nostr-event:

```jsonc
{
  "kind": 30951,
  "tags": [["d", "nostrm-schema"]],
  "content": {
    "company": { "key1":"BTW", "key2":"Segment", "key3":"Owner", "key4":"KvK" },
    "relations": { /* override/aanvulling op de default-vocabulaire uit §3.3 */ },
    "detailFields": ["phone1","phone2","phone3","phone4","email","twitter","linkedin","price"]
  }
}
```

Eén plek, versievast (replaceable), en meereisbaar tussen teamleden.

---

## 7. Privacy & security

CRM-data is gevoelig. Drie lagen:

1. **Afgeschermde relay (NIP-42):** de LNbits-relay accepteert alleen
   reads/writes van geautoriseerde pubkeys (de CRM-eigenaar + teamleden). Zo
   ziet niemand anders de events, ook al kennen ze de URL.
2. **Encryptie-at-rest (optioneel, NIP-44):** versleutel het `content`-veld
   met een CRM-sleutel (self-encryption of gedeelde team-sleutel). Dan is de
   data zelfs bij een relay-lek onleesbaar. Trade-off: geen relay-side zoeken
   op inhoud → client doorzoekt lokaal de in-memory index. **Aanbeveling: aan
   voor v1**, want het is een CRM.
3. **Geen geheimen in tags:** alleen niet-gevoelige zoekvelden (`name`, `t`,
   `k`) in tags. Telefoon/e-mail/adres uitsluitend in (versleutelde) `content`.

> Conform CLAUDE.md: nsecs nooit in chat/commits; sleutels via
> `.env.services` / app-`.env`. De CRM-app-nsec hoort in
> `apps/nostrm/.env`.

**Multi-user:** elk teamlid heeft een eigen keypair op de NIP-42-allowlist.
`author` op een event = wie het schreef (audit trail in History). Voor gedeelde
encryptie deel je één symmetrische CRM-sleutel (out-of-band, of via NIP-44 DM).

---

## 8. Technische stack (voorstel, lean — past bij de lab-conventies)

- **Frontend:** statische SPA (vanilla of lichte framework), serveerbaar onder
  `https://goosielabs.com/apps/nostrm` — geen build-zwaarte, RAM-vriendelijk.
- **Nostr lib:** `nostr-tools` (events, NIP-44, NIP-42 auth, signing).
- **Signing:** NIP-07 browser-extensie (Alby/nos2x) of een app-nsec voor
  headless taken.
- **Opslag:** uitsluitend de LNbits-relay. Lokale cache in IndexedDB voor
  snelheid/offline.
- **Documenten-blobs:** Blossom-server of nostr.build; in NostrM bewaren we
  alleen URL + sha256.
- **Geen aparte backend nodig** voor de kern — relay = backend. Alleen een
  dunne Node-helper als je server-side automations wilt (bijv. History-entries
  genereren uit betalingen).

---

## 9. Bouwfasering (roadmap)

| Fase | Inhoud |
|------|--------|
| **0 — Relay** | LNbits Nostr Relay aanzetten, NIP-42 allowlist, app-keypair |
| **1 — Entiteiten** | CRUD voor Companies + Contacts (kinds 30900/30901), hiërarchie-boom, secties 2–5 |
| **2 — Edges** | Link-events (30950), relatietype-picker, n→n + zelf-relaties |
| **3 — Overige categorieën** | Documents, Agenda, Todo, Products, Details, History → sectie 6 |
| **4 — Config & search** | Schema-event (30951), key-veld-labels, lokale full-text search |
| **5 — Privacy** | NIP-44 encryptie-at-rest, multi-user allowlist |
| **6 — Extra's** | NIP-52 agenda-export, Lightning (zaps/betaalde docs), badges, import/export |

---

## 10. Open beslissingen (graag jouw keuze)

1. **Encryptie v1:** NIP-44-at-rest meteen aan (privacy) of eerst plain om
   sneller te bouwen? → *aanbeveling: aan.*
2. **Multi-user nu of later:** single-key (jij) of direct team-allowlist?
3. **Agenda:** eigen kind `30903` met NIP-52-export, of meteen native NIP-52?
4. **Documenten-opslag:** Blossom (self-host op de server) vs nostr.build?
5. **Key-veld labels:** vaste set of volledig per-CRM configureerbaar via
   `30951` (aanbevolen)?

---

## Appendix A — Samenvattend datamodel

```
Entiteiten (addressable, kind:pubkey:d)
  30900 Company   ── name, address1-3, state, zip, city, country, key1-4
  30901 Contact   ── first/mid/lastname, address1-3, state, zip, country
  30902 Document  ── title, kind, url, hash, body
  30903 Agenda    ── title, start, end, location, notes
  30904 Todo      ── title, status, due, priority
  30905 History   ── type, at, summary (append-only)
  30906 Product   ── name, sku, description
  30907 Details   ── phone1-4, email, twitter, linkedin, price, custom{}

Edges (first-class)
  30950 Link  ── a:from, a:to, rel, inv, dir(directed|mutual), k-tags, content{role,since,weight}

Config
  30951 Schema ── key-veld labels, relatie-vocabulaire, detail-velden
  30952 View   ── opgeslagen filters/weergaven
```

Alles n→n, alles getypeerd, alles op één eigen relay.
