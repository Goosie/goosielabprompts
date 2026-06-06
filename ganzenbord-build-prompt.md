# 🪿 Build: Ganzenbord — The Living Nostr Board Game

You are building **Ganzenbord**, a multiplayer Game of the Goose that lives
entirely on Nostr. Players are real Nostr identities. The board is alive:
when a new Goosie Labs app launches, a new card appears on the board.
Sats flow via Lightning. Everything is beautiful, animated, and joyful.

---

## CONTEXT — READ FIRST

This is a Goosie Labs app. The stack is Vite + React + TypeScript.
All Nostr hooks, auth, and boilerplate are already present (see CLAUDE.md).
App runs at `/apps/ganzenbord/`. The Goosie relay is the primary relay.

---

## GAME RULES — implement exactly

**Board:** 63 squares in a classic spiral. Players start off the board (position 0).

**Goal:** First to land EXACTLY on square 63 wins.

**Overshoot:** Roll past 63 → bounce back the excess (e.g. at 61, roll 5 → 63+2 back = 61).

**Goose squares** (5, 9, 14, 18, 23, 27, 32, 36, 41, 45, 50, 54, 59):
→ "Double your journey!" — move forward again by the same roll.
→ If the next square is also a Goose, keep going.

**Special hazard squares:**
| Square | Name | Effect |
|--------|------|--------|
| 6 | The Bridge | Jump to square 12 |
| 19 | The Inn | Miss 1 turn (rest) |
| 31 | The Well | Stuck until another player lands here and swaps |
| 42 | The Maze | Go back to square 30 |
| 52 | The Prison | Stuck until another player lands here and swaps |
| 58 | Death | Back to square 0, start over |

**First move special rule:**
- Roll 6+3 on your very first roll → jump to square 26
- Roll 4+5 on your very first roll → jump to square 53

**Bump rule:** If you land on a square already occupied → the other player
goes back to where YOU just came from.

**Turn order:** Clockwise. Each turn: player rolls 2 dice, moves, effect resolves,
next player's turn.

**Dice:** Server-side RNG using commit-reveal: server signs the dice result with
its Nostr keypair. Clients verify the signature. No cheating possible.

---

## NOSTR PROTOCOL — event kinds

Use the Goosie relay (`wss://relay.goosielabs.com`) as primary.

```
kind: 30420  GameRoom (addressable, d=room-id)
  — host pubkey, player list (pubkeys), status: "waiting|active|finished"
  — entry_fee_sats, pot_pubkey (Lightning address), max_players (2-6)
  — Published by host. Replaced on every state change.

kind: 30421  GameState (addressable, d=room-id)
  — positions: {pubkey: square}, turn: pubkey, round: number
  — scores: {pubkey: sats_won}, status: "active|finished", winner: pubkey|null
  — Published by the game server identity after every move resolves.

kind: 20420  JoinRequest (ephemeral)
  — p: host pubkey, d: room-id
  — content: Lightning proof (payment hash or zap receipt event id)

kind: 20421  RollRequest (ephemeral)
  — p: server pubkey, d: room-id
  — content: player's random seed commitment (SHA256 of a secret number)

kind: 20422  DiceResult (ephemeral, published by server)
  — p: player pubkey, d: room-id
  — content: JSON { die1, die2, server_seed, player_seed_reveal,
                    from_square, to_square, effect, effect_detail }
  — Server signature proves result is unforgeable.

kind: 20423  GameEvent (ephemeral, published by server)
  — d: room-id
  — content: JSON { type: "bump|well_release|prison_release|chat",
                    player, affected_player, message }

kind: 30422  BoardConfig (addressable, d="ganzenbord-board", author=server)
  — content: JSON array of 63 square definitions (see Living Board section)
  — Replace this event to update the board → all clients live-update instantly
```

**Game server identity:** A dedicated Nostr keypair stored server-side
(like Blocky). It signs all DiceResult and GameState events.
Store keypair in `agents/ganzenbord/nostr-key.json` format.

---

## THE LIVING BOARD — this is the magic ✨

Every square on the board is configurable via the `BoardConfig` event.
Each square definition:

```json
{
  "square": 7,
  "type": "normal|goose|hazard|app",
  "hazard": null,
  "app": {
    "name": "CatchZaps",
    "url": "/apps/catchzaps/",
    "icon": "⚡",
    "color": "#f59e0b",
    "effect": "win_sats",
    "effect_sats": 10,
    "description": "You caught a zap! Collect 10 sats from the pot."
  }
}
```

**App square effect types:**
- `win_sats` — collect N sats from the pot
- `lose_sats` — pay N sats into the pot
- `skip_turn` — miss next turn (like Inn)
- `teleport_to` — jump to another square
- `goose` — double roll like classic goose squares
- `challenge` — mini-challenge modal appears (trivia about the app)

**When Perry launches a new Goosie Labs app:**
The server (or Perry via the admin panel) publishes a new `kind:30422` BoardConfig
replacing one "normal" square with the new app card. All active games
see the change instantly on the next page render.

**Default board:** Start with the 63 classic squares + replace ~12 "normal"
squares with existing Goosie Labs apps (see App Squares section below).

---

## APP SQUARES — pre-populate with Goosie Labs apps

Place these on the board by default (spread them out evenly across the spiral):

| App | Color | Icon | Effect | Description shown to player |
|-----|-------|------|--------|------------------------------|
| CatchZaps | #f59e0b | ⚡ | win 21 sats | "You caught a zap! +21 sats." |
| ZapHunt | #8b5cf6 | 🗺️ | win 42 sats | "You found the treasure! +42 sats." |
| Sofia | #06b6d4 | ✈️ | teleport_to 54 | "Group trip! Fast-forward to 54." |
| IDidHere | #10b981 | 📍 | goose | "Proof of move! Double your roll." |
| Zinin | #ec4899 | 💫 | lose 10 sats | "Wrong match. -10 sats." |
| Honkference | #6366f1 | 🎙️ | skip_turn | "You're presenting. Miss a turn." |
| ProofOfMove | #ef4444 | 🏃 | win 5 sats | "You trained! +5 sats per square moved." |
| [empty slot] | #d1d5db | 🪿 | normal | (reserved for next app) |
| [empty slot] | #d1d5db | 🪿 | normal | (reserved for next app) |
| [empty slot] | #d1d5db | 🪿 | normal | (reserved for next app) |
| [empty slot] | #d1d5db | 🪿 | normal | (reserved for next app) |
| [empty slot] | #d1d5db | 🪿 | normal | (reserved for next app) |

---

## LIGHTNING & SATS

**Entry flow:**
1. Host sets entry fee (default: 21 sats). A Lightning address/invoice is shown.
2. Player pays → sends `kind:20420 JoinRequest` with zap receipt as proof.
3. Server verifies zap receipt on relay, then adds player to GameRoom.

**In-game sats:** App squares with `win_sats`/`lose_sats` effects move
sats between the pot and a player's balance (tracked in GameState).

**Payout:** Winner receives the full pot via Lightning invoice they provide,
or via NWC (NIP-47) if they've connected a wallet.

**Implementation:** Use LNbits subwallet per game room (same pattern as ZapHunt).
LNbits config already in server `.env`. API: `http://127.0.0.1:5000`.

**Free mode:** Entry fee = 0 sats is valid. Pure bragging rights.

---

## VISUAL DESIGN — make it gorgeous

**Board:**
- Classic spiral layout, 63 numbered squares in a snaking path from outside-in
- Each square is a rounded card, ~80px on desktop, ~50px on mobile
- Goose squares: warm golden background (#f4a261), 🪿 emoji, subtle shimmer
- Hazard squares: unique illustration per type:
  - Bridge (6): 🌉 teal (#0d9488)
  - Inn (19): 🍺 amber (#d97706)
  - Well (31): 🪣 blue (#2563eb)
  - Maze (42): 🌀 purple (#7c3aed)
  - Prison (52): ⛓️ dark gray (#374151)
  - Death (58): 💀 black + red glow
- App squares: app's `color` as background, icon + short name
- Normal squares: parchment (#faf3e0), subtle border
- Square 63 (center of spiral): large, golden burst, 👑 crown
- Current player's possible landing square: subtle highlight pulse

**Player tokens:**
- Each player = their Nostr profile picture in a circle (fallback: colored initial)
- Unique colored ring per player (amber / teal / rose / violet / lime / sky)
- Drop shadow. When multiple tokens on same square: fan out with offset
- Movement: smooth CSS transition along the path, 300ms ease-out per square,
  chained for multi-square moves

**Dice:**
- Two large dice using CSS 3D perspective transform (not images)
- Dice faces use dot pips (SVG), classic white cube with black dots
- Roll animation: shake + tumble for 600ms, snap to result face
- Roll button pulses with the current player's ring color when it's your turn
- Show both dice + sum clearly

**UI layout:**
- Desktop: board takes 70% width left, right panel 30%
- Right panel: player list (avatar + name + position + sats), turn indicator
  (pulsing border on active player), last 8 events in a log, chat input
- Top bar: room name, round number, pot size in sats ⚡
- Mobile: board on top (full width), panels as tabs below (Players / Log / Chat)

**Animations & feedback:**
- Land on goose square → wings flap animation + "DOUBLE! 🪿" toast (green)
- Land on Death → skull animation + red flash + "Back to start! 💀" toast
- Land on app square → app card modal slides up with description + effect
- Land on Bridge → arc animation directly to square 12
- Someone wins → full-screen confetti (CSS only, no library) + winner avatar
  grows large + sats amount animates flying to their balance
- Bump → bumped player token slides back with a "bump!" indicator

**Color palette:**
- Base: parchment #faf3e0
- Board background: aged paper texture via CSS (radial gradient + noise)
- Accent: forest green #2d6a4f
- Gold: #f4a261
- Text: #1c1917

---

## FILE STRUCTURE

```
src/
  components/
    Board.tsx            ← spiral board renderer, reads BoardConfig from Nostr
    Square.tsx           ← individual square, handles all types + hover state
    PlayerToken.tsx      ← avatar circle with ring color + movement animation
    Dice.tsx             ← 3D CSS dice with roll animation
    GameLog.tsx          ← scrollable event log
    PlayerPanel.tsx      ← right panel: players, turn, sats balances
    AppSquareModal.tsx   ← bottom sheet when landing on app square
    LobbyRoom.tsx        ← waiting room: player list, invite link, start button
    WinnerModal.tsx      ← confetti + winner display + payout button
    AdminPanel.tsx       ← /admin: board editor, publish BoardConfig
  hooks/
    useGameRoom.ts       ← subscribe kind:30420
    useGameState.ts      ← subscribe kind:30421
    useBoardConfig.ts    ← subscribe kind:30422 (live board updates)
    useGameServer.ts     ← publish RollRequests, handle DiceResults
    useLightning.ts      ← LNbits: create invoice, verify payment, payout
  lib/
    gameLogic.ts         ← pure functions: resolveMove(), applyEffect(),
                           computeNextPosition(), validateWin(), isGoose()
    boardLayout.ts       ← spiral coordinate math: square N → {x, y} on grid
    nostrGame.ts         ← event builders for all game kinds
    defaultBoard.ts      ← hardcoded default BoardConfig (63 squares)
  pages/
    LobbyPage.tsx        ← list of open rooms + create new room button
    GamePage.tsx         ← main game (Board + panels)
    AdminPage.tsx        ← board editor (Perry only)
  server/
    gameServer.ts        ← Node.js service (see Server section)
    lightningService.ts  ← LNbits API wrapper
```

---

## SERVER SERVICE

The game server is a Node.js process (`src/server/gameServer.ts`) that:
1. Connects to relay with `agents/ganzenbord/nostr-key.json` keypair
2. Listens for `kind:20421` RollRequest events
3. Generates dice via commit-reveal XOR (server_seed XOR player_seed)
4. Resolves full game logic (position, effects, goose chains, bump, well/prison)
5. Publishes signed `kind:20422 DiceResult`
6. Publishes updated `kind:30421 GameState`
7. Detects win condition → publishes final GameState, triggers LNbits payout

**Run:** `node dist/server/gameServer.js`
**Service name:** `ganzenbord-server`
**Systemd unit:** `/etc/systemd/system/ganzenbord-server.service`

---

## BOARD ADMIN PANEL

Route: `/apps/ganzenbord/admin` — protected: only Perry's pubkey can access
(check against `npub14qmyh789hq5t6u32dhr33qhlfm5dx70xf7l5tp8scmcm8ylcqkxqds0r58`).

Features:
- Visual grid of all 63 squares, current config displayed
- Click any square → drawer opens: edit type, app name, url, icon, color, effect
- "Add new Goosie Labs app" shortcut button at top
- "Publish to Nostr" → publishes `kind:30422 BoardConfig` from server keypair
- All active games update their board live within seconds of publishing

---

## MVP BUILD ORDER

Build in this exact sequence, commit after each step:

1. **Board rendering** — static board, correct spiral layout, all 63 squares
   styled correctly (goose, hazard, app, normal), responsive
2. **Game logic** — pure `gameLogic.ts`: all rules, special squares,
   goose chaining, bounce-back, bump rule — with unit tests
3. **Nostr game server** — keypair setup, relay connection, event processing,
   dice generation, GameState publishing
4. **Lobby** — create room (kind:30420), join room, player list, invite link
5. **Game loop** — roll button → RollRequest → DiceResult → resolve → animate
6. **Visual polish** — all token animations, dice animation, app square modals,
   winner screen, confetti
7. **Live board** — subscribe to kind:30422, board updates live in all clients
8. **Admin panel** — board editor, publish BoardConfig to Nostr
9. **Lightning** — entry fee invoices, sats tracking in GameState, winner payout

---

## QUALITY CHECKLIST

- [ ] All 63 squares render in correct spiral layout
- [ ] All hazard squares behave correctly (test each one)
- [ ] Goose chaining works (multiple consecutive geese)
- [ ] Overshoot bounce-back from 63 works
- [ ] Bump rule displaces other player correctly
- [ ] First-move specials (6+3→26, 4+5→53) work
- [ ] Well and Prison: stuck until relieved by another player
- [ ] Server signs all dice results; client can verify signature
- [ ] BoardConfig subscription updates board live without page refresh
- [ ] Admin panel only accessible to Perry's pubkey
- [ ] Mobile layout works correctly
- [ ] No private keys anywhere in frontend
- [ ] `npm run build` passes with zero TypeScript errors
- [ ] `npm audit` clean

---

## THE VISION

This is not just a game. It is a **living map of Goosie Labs**.

Every app Perry ships becomes a square on the board.
Players are real people with real Nostr identities.
Real sats change hands.
Victories are published to the Nostr timeline for everyone to see.
The board grows with the lab.
When a new app launches, the board changes — in every ongoing game, instantly.

🪿 Build the most beautiful Ganzenbord ever made.
