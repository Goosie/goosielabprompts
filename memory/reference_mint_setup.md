---
name: reference-mint-setup
description: "Cashu mint (Nutshell 0.20.0) config facts — funding, nginx websocket fix, v2-keyset wallet incompatibility"
metadata: 
  node_type: memory
  type: reference
  originSessionId: fafa9dec-e815-440a-9769-0e7b2e952dd1
---

Goosie Labs Cashu mint = Nutshell **0.20.0**, runs from local source `/home/deploy/nutshell/cashu/` (editable). Service `nutshell.service`, port 3338, DB `/home/deploy/nutshell/data/mint/mint.sqlite3`, config `/home/deploy/nutshell/.env`.

**Funding:** backend `LNbitsWallet` → `https://lnbits.goosielabs.com`. LNbits itself uses `LndRestWallet` → `https://umbrel.local:8080`. `umbrel.local` is a static `/etc/hosts` entry = `100.111.14.11` (Tailscale). MUST stay the hostname `umbrel.local`, NOT the raw IP — LND's TLS cert SAN covers `DNS:umbrel.local` but NOT `IP:100.111.14.11`, so the IP form fails cert verification. NWC/Alby is disabled (commented out). So it is already on Perry's own LND.

**nginx websocket fix (2026-06-18):** mint nginx config `/etc/nginx/sites-available/mint.goosielabs.com` was missing `proxy_set_header Upgrade $http_upgrade;` + `proxy_set_header Connection "upgrade";` in `location /`. Without them NUT-17 `/v1/ws` returned 404 through nginx (101 direct). Added them (matches lnbits config pattern). The "Exception in ASGI application" log line on ws disconnect is benign noise.

**v2 keyset incompatibility:** Nutshell >= 0.20.0 generates **v2 keyset IDs** (`01…`-prefix, 66 hex chars) via `derive_keyset_id_v2` (see `core/base.py` ~line 958: `version_tuple < (0,20)` → v1, else v2). Older wallets (e.g. some 0xchat builds) can't parse v2 keysets and abort with "mint failed" after reading metadata, before requesting an invoice. Mint works fine with v2-aware clients (cashu CLI, web wallet — 573 sats already issued). Default `mint_input_fee_ppk = 100` is also a Nutshell 0.20.0 default, not a misconfig. To force a universally-compatible v1 keyset would require a keyset rotation with version forced < 0.20 (old keyset stays active for redeeming existing tokens).

**Rate limiter (the actual 0xchat "mint failed"/stuck-deposit cause, 2026-06-18):** Nutshell 0.20.0 defaults to an IP rate limiter ON: `mint_global_rate_limit_per_minute=60`, `mint_transaction_rate_limit_per_minute=20`. 0xchat retries `POST /v1/mint/bolt11` ~10×/sec, instantly blowing past 20/min → permanent `429` loop → paid invoices stay `PAID` and never reach `ISSUED` (ecash never claimed). Fix: set `MINT_GLOBAL_RATE_LIMIT_PER_MINUTE` + `MINT_TRANSACTION_RATE_LIMIT_PER_MINUTE` in `/home/deploy/nutshell/.env`, `sudo systemctl restart nutshell`. Tuned values: global=1000, transaction=600. NB transaction must stay >= ~600 because 0xchat retries `/v1/mint` ~10/sec (600/min) — set it lower and the 429 lockout returns. Rate limit = requests/min per IP, NOT a sat-amount cap. The service has NO `EnvironmentFile=`; the app reads `.env` from `WorkingDirectory=/home/deploy/nutshell` via pydantic-settings (env var = uppercased field name). After fix, deposit claimed immediately. NB: 0xchat then keeps retrying an already-ISSUED quote → harmless `400`s; user must force-close/reopen the app. v2 keyset turned out NOT to be the blocker — 0xchat 1.5.5 (latest, 2026-03-11) handles the mint fine once rate limits are raised.

**Quote states:** UNPAID (invoice made) → PAID (sats received by mint) → ISSUED (wallet claimed ecash). Mint backed by its LNbits wallet (key in nutshell/.env). Funding own mint from own LND = self-payment, blocked; pay via LNbits "paste request" (internal settle) or an external wallet (e.g. Phoenix). NUT-09 `/v1/restore` available for recovering blind sigs if a wallet loses the mint response.

Related: [[user-perry]]
