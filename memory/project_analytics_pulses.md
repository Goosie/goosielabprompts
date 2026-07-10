---
name: project_analytics_pulses
description: Commy owns two private analytics DMs to Perry — daily web visitor pulse + weekly Nostr flock-traction pulse
metadata: 
  node_type: memory
  type: project
  originSessionId: 009186ed-17b2-4f54-968f-e5017b3b2102
---

Perry wanted to know "are people actually visiting / following us?" — delivered as private Nostr DMs from a goose (he chose DM over a login-gated dashboard tile). **Commy** owns both:

- **Daily visitor pulse** — `scripts/commy/traffic-pulse.mjs`, Blocky key `commy-traffic` (144 blocks). Parses nginx `access.log`, strips bot/scanner probes, reports visits/apps/referrers/country. Country via local DB-IP mmdb at `data/geo/dbip-country-lite.mmdb` (self-refreshes monthly; reader = `maxmind` npm in `scripts/commy/node_modules`).
- **Weekly flock-traction pulse** — `scripts/commy/flock-traction.mjs`, Blocky key `commy-traction` (1008 blocks). Queries relay.goosielabs.com + damus + nos.lol + primal for kind 3/7/9735 p-tagging each goose; excludes flock-internal follows + Perry to show OUTSIDE interest only.

Design rules that matter: **numbers stay in the private DM** (script stdout is neutral so the public kind-6000/heartbeat leaks nothing). Honesty baked in: bot caveat, homepage-on-Blossom blind spot, outbox-model caveat (follower counts are a lower bound), bookmarks deliberately not reported (unmeasurable). Dispatch runs through `commy/index.mjs` subcommands (`traffic-pulse`, `flock-traction`) via goose-runner `handleScript`.

Baseline at launch (2026-07-10): ~3 real human visitors/day (Google search sends ~11 clicks), and near-zero Nostr traction — only Welcome had 1 external follower + 1 reaction. Watching these climb is the mission's "real returning person" KPI. Fixed en route: `commy/index.mjs` imported nostr-tools from a deleted app (`catchzaps`) — repointed to `skein`, un-breaking Commy's public posting too. See [[feedback_blocky_time_source]].
