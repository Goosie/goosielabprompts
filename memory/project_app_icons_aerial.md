---
name: project-app-icons-aerial
description: "Aerial diorama app icon series — status, prompt recipe, and todo for newapp integration"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9f32bcb6-d0b5-4bc4-ab0e-e4d559595cb0
---

Perry is moving all app icons to an "aerial diorama" series generated with gpt-image-1.

**Why:** Matches the flat cartoon style of the goose portraits, ties all icons to the flock. Small V-formation silhouette in bottom-left corner as subtle Goosie Labs signature.

**Script:** `/home/deploy/systemsetup/scripts/generate-app-icons-ai.mjs`
**Style const:** `AERIAL` (defined in that file)
**Committed + pushed:** 2026-06-14, `Goosie/systemsetup` main

## The AERIAL recipe (Perry's design, verbatim)
```
flat 2D cartoon illustration, thick black outlines, cel shading, vector art style, warm cream background, high quality. High-angle bird's-eye view, looking down at a small scene from above — what a goose sees while flying over it. In one corner of the icon, three small semi-transparent goose-shaped shadows flying together in a V-formation — a light grey silhouette of three geese, barely-there, drifting across the corner of the scene. Always three geese in V-formation, never one. Centred composition with even empty space around it so it reads cleanly as a square app icon. Classic cartoon animation style, the same flat look as the Goosie Labs geese. NOT realistic, NOT 3D render, NOT photo, no text, no letters — flat cartoon only.
```

Note: gameofthegoose uses a custom prompt (not AERIAL base) to avoid shadow bleed — uses the flat cartoon style directly with explicit V-formation instruction.

## gameofthegoose prompt (final, approved by Perry)
```
flat 2D cartoon illustration, thick black outlines, cel shading, vector art style, warm cream background, high quality. A simple spiral board game path on a calm green field, seen slightly from above. Just the winding path with a few numbered tiles — calm, minimal, lots of breathing room. Warm greens and soft golds. In the bottom-left corner, three small goose silhouettes flying in a V-formation — noticeable but still secondary, like a charming detail rather than the main element. NOT realistic, NOT 3D render, NOT photo, no text — flat cartoon only.
```

## App scenes still to do (Perry's list)
- **ProofOfRead** — open book on a wooden desk, round reading glasses and a steaming mug beside it
- **Goosie Mint** — coin-mint press with neat stacks of golden coins, one stamped with a lightning bolt
- **Georgie Trip** — folded travel map with a winding dotted trail, small pins, tiny mountains and a river
- **Honkensus** — round wooden table, ringed by small stools, three speech-bubble tokens meeting in the middle
- **Dilemma** — forked dirt path splitting two ways across a meadow, a single gold coin at the junction
- **ZapHunt** — treasure map with a red X, a dotted route, and a few gold coins scattered around
- **lastwill** — wax-sealed envelope and an old brass key on a desk, beside a small hourglass
- All other active apps (catchzaps, honkbadge, zinin, etc.)

## TODO
- [ ] Do remaining apps one by one (Perry wants to review each before moving to next)
- [ ] **Optional: scene-preview UI in newapp-web** — currently scene is auto-derived from the first sentence of `description`. A field with the derived text pre-filled + regenerate-button would give more control.
- [ ] After each icon: `bash /home/deploy/update-tiles.sh` to publish to homepage

## Done — newapp wiring (2026-06-16)
- `generate-app-icons-ai.mjs` accepts ad-hoc invocation: `--name <n> --scene "<one-line>"` → builds `${AERIAL} The scene: <scene>` on the fly, no need to add to the `apps` array first.
- `newapp.sh` 2nd arg is now `SCENE` (was emoji glyph; emoji glyph moved to 3rd arg). If scene + `OPENAI_API_KEY` set → AERIAL icon; else fallback to emoji placeholder.
- `newapp-web` (backend `build.ts`): step 6 uses AERIAL with `shortDescription(description)` as scene when `OPENAI_API_KEY` available; falls back to emoji on failure. Tile description = `shortDescription(description)` too — first non-empty non-heading line of the build brief, capped at 250 chars. No more multi-page briefs in tile descriptions.

## Done
- [x] 2026-06-15 — zaphunt icon (treasure map, red X, dotted route, gold coins, V-formation shadow top-left)
- [x] 2026-06-15 — AERIAL recipe updated: always THREE geese in V-formation shadow in a corner, never a single goose silhouette

**How to apply:** `source /home/deploy/.env.services && export OPENAI_API_KEY && node /home/deploy/systemsetup/scripts/generate-app-icons-ai.mjs <appname>`
