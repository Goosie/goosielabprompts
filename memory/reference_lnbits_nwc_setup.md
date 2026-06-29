---
name: reference-lnbits-nwc-setup
description: How to make LNbits an NWC provider for Nostr clients (Amethyst zaps) — the non-obvious dependency chain
metadata: 
  node_type: memory
  type: reference
  originSessionId: d4a856fb-f003-44ab-b4ec-61649a01b9a9
---

To let a Nostr client (Amethyst, etc.) zap via an LNbits wallet over NWC (NIP-47), three things must all be in place — the timeout/403 errors come from missing pieces of this chain:

1. **NWC Service Provider** extension (`nwcprovider`) installed + enabled — creates the `nostr+walletconnect://` pairing string per wallet.
2. **Nostr Client** extension (`nostrclient`) installed + enabled — nwcprovider does NOT talk to relays directly, it proxies through nostrclient. Missing nostrclient → `Error connecting to NWC relay: HTTP 403` reconnect loop → "wallet request time out" in the client.
3. In Nostr Client settings: **"Expose Public Websocket" must be ON** (config `public_ws`, default `false`). nwcprovider connects on the `relay` ws channel which requires `public_ws=true`. Default-off → 403 "Public websocket connections not accepted".
4. Add a **public relay** in Nostr Client (e.g. `wss://nos.lol`, `wss://relay.primal.net`). NOT our own `relay.goosielabs.com` — it is write-restricted (whitelist.json + policy.js) and rejects the NWC event kinds from non-whitelisted pubkeys. The relay in the client's pairing string must match a relay nostrclient is connected to → safest to recreate the pairing after configuring relays.

NWC connection binds to the **specific wallet** it was created in (not the user account), so it only spends that wallet's internal balance. All goose wallets sit under one LNbits user ("superhero") → internal transfers between them are free/instant for topping up a zap wallet. See [[reference-mint-setup]].

⚠️ DO NOT block `/nostrclient/api/v1/relay` at nginx to "close the public websocket" — it breaks external NWC clients. With nwcprovider config `relay=nostrclient` and EMPTY `relay_alias`, the pairing string handed to clients (Amethyst etc.) sets relay = `wss://<host>/nostrclient/api/v1/relay` (built from the request netloc). The phone connects to THAT endpoint as its relay. An nginx `deny`/403 there → "wallet request time out" + balance shows 0 (wallet is fine, it's a transport block). Verified the hard way: a deny rule there silently broke Amethyst hours later. Symptom checklist when NWC times out: nwcprovider `keys.last_used` stops updating = client requests not arriving = transport/relay problem, not funds.

To safely close that public endpoint: set nwcprovider `relay_alias = wss://nos.lol` (a real public relay nostrclient/nwcprovider already connect to) and RE-PAIR the client (new QR), so the pairing string points to nos.lol instead of the LNbits endpoint. Only then can `/nostrclient/api/v1/relay` be firewalled.

Connections can also drop on their own (idle websocket) without a systemd restart — `sudo systemctl restart lnbits` re-establishes nostrclient relay + nwcprovider links cleanly.

Geese themselves do NOT need NWC — they pay server-side via the LNbits API (X-Api-Key). NWC is only for client apps.
