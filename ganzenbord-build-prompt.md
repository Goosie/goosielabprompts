# 🪿 Build: Game of the Goose — The Living Nostr Board Game

You are building **Game of the Goose** (Ganzenbord), a multiplayer board game
that lives entirely on Nostr. Players are real Nostr identities. The board is
alive: when a new Goosie Labs app launches, a new card appears on the board.
Sats flow via Lightning. Everything is beautiful, animated, and joyful.

---

## HOW TO USE THIS PROMPT

This is a large project. Build it **one step at a time**.
Each step ends with: `npm run build` (zero errors) + a git commit.
Do NOT start the next step until the current one builds cleanly.

Steps in order:
1. Game logic (pure functions, no UI)
2. Static board rendering (UI, no Nostr yet)
3. Nostr game server (backend service)
4. Lobby (create/join rooms via Nostr)
5. Game loop (roll → move → animate)
6. Visual polish (animations, modals, winner screen)
7. Live board (BoardConfig from Nostr, updates live)
8. Admin panel (edit board, publish to Nostr)
9. Lightning (entry fee, sats tracking, payout)

**Start with Step 1. Say "next" to proceed to the next step.**

---

## CONTEXT

This is a Goosie Labs app. Stack: Vite + React + TypeScript.
All Nostr hooks, auth, and boilerplate are already present (see CLAUDE.md).
App name: `ganzenbord` — runs at `/apps/ganzenbord/`.
Primary relay: `wss://relay.goosielabs.com`

---

## GAME RULES — full specification

**Board:** 63 squares in a classic spiral. Players start at position 0 (off board).

**Goal:** First to land EXACTLY on square 63 wins.

**Overshoot:** Roll past 63 → bounce back the excess.
Example: at square 61, roll 5 → go to 63, overshoot by 2 → land on 61.

**Goose squares** — numbers: 5, 9, 14, 18, 23, 27, 32, 36, 41, 45, 50, 54, 59
Effect: "Double your journey!" — move forward again by the same roll amount.
If the new square is also a Goose, keep going (chain until non-Goose).

**Special hazard squares:**
| Square | Name | Effect |
|--------|------|--------|
| 6 | The Bridge | Jump immediately to square 12 |
| 19 | The Inn | Miss your next turn |
| 31 | The Well | Stuck. Wait until another player lands here — they take your place, you go where they came from |
| 42 | The Maze | Go back to square 30 |
| 52 | The Prison | Stuck. Same swap rule as the Well |
| 58 | Death | Back to square 0, start over |

**First move special rule** (only applies on each player's very first roll):
- Roll 6+3 (total 9) → jump to square 26
- Roll 4+5 (total 9) → jump to square 53
- Any other total → move normally

**Bump rule:** Land on a square already occupied by another player →
that player moves back to the square you just left.

**Turn order:** Clockwise. Each turn: roll 2 dice → move → resolve effect → next player.

**Dice fairness:** Server generates dice using commit-reveal.
Player sends SHA256 commitment of a random secret. Server XORs with its own
random seed and signs the result. Client verifies signature before accepting.

---

## NOSTR PROTOCOL — all event kinds

```
kind: 30420  GameRoom           (addressable, d=room-id, author=host)
  content: {
    host, players: [pubkey], status: "waiting|active|finished",
    entry_fee_sats, max_players, created_at
  }

kind: 30421  GameState          (addressable, d=room-id, author=server)
  content: {
    positions: { [pubkey]: square },
    turn: pubkey,
    round: number,
    balances: { [pubkey]: sats },
    pot_sats: number,
    skipped: [pubkey],         ← players missing their turn
    stuck: { [pubkey]: "well"|"prison" },
    status: "active"|"finished",
    winner: pubkey|null,
    first_roll_done: [pubkey]  ← tracks who has used their first roll
  }

kind: 20420  JoinRequest        (ephemeral, author=player)
  tags: [["p", host_pubkey], ["d", room-id]]
  content: { zap_receipt_id }  ← proof of payment (or empty for free games)

kind: 20421  RollRequest        (ephemeral, author=player)
  tags: [["p", server_pubkey], ["d", room-id]]
  content: { commitment: "sha256hex" }

kind: 20422  DiceResult         (ephemeral, author=server)
  tags: [["p", player_pubkey], ["d", room-id]]
  content: {
    die1, die2,
    server_seed: "hex",
    from_square, to_square,
    effect: "none|goose|bridge|inn|well|maze|prison|death|app|bump|win",
    effect_detail: string,
    bumped_player: pubkey|null,
    bumped_to: number|null
  }

kind: 20423  GameEvent          (ephemeral, author=server)
  tags: [["d", room-id]]
  content: {
    type: "well_release"|"prison_release"|"chat",
    player, affected_player, message
  }

kind: 30422  BoardConfig        (addressable, d="ganzenbord-board", author=server)
  content: JSON array of 63 square objects (see Living Board section)
  ← Replacing this event updates the board live in ALL active games
```

**Server identity:** A dedicated Nostr keypair stored at
`/home/deploy/agents/ganzenbord/nostr-key.json` (same format as Blocky).
The server signs all DiceResult and GameState events.

---

## THE LIVING BOARD ✨

Every square is configurable via the `BoardConfig` Nostr event.
Replacing that event updates every active game's board in real time.

Each square object:
```json
{
  "square": 7,
  "type": "normal" | "goose" | "hazard" | "app",
  "hazard": "bridge" | "inn" | "well" | "maze" | "prison" | "death" | null,
  "app": {
    "name": "CatchZaps",
    "url": "/apps/catchzaps/",
    "icon": "⚡",
    "color": "#f59e0b",
    "effect": "win_sats" | "lose_sats" | "skip_turn" | "teleport_to" | "goose",
    "effect_value": 21,
    "description": "You caught a zap! Collect 21 sats from the pot."
  }
}
```

**Default board:** hardcode in `src/lib/defaultBoard.ts`.
Classic squares + these Goosie Labs app squares spread across the board:

| Square | App | Color | Icon | Effect |
|--------|-----|-------|------|--------|
| 8 | CatchZaps | #f59e0b | ⚡ | win 21 sats |
| 15 | ZapHunt | #8b5cf6 | 🗺️ | win 42 sats |
| 22 | Sofia | #06b6d4 | ✈️ | teleport to 54 |
| 29 | IDidHere | #10b981 | 📍 | goose (double roll) |
| 37 | Zinin | #ec4899 | 💫 | lose 10 sats |
| 44 | Honkference | #6366f1 | 🎙️ | skip turn |
| 48 | ProofOfMove | #ef4444 | 🏃 | win 5 sats |
| 3 | [reserved] | #d1d5db | 🪿 | normal |
| 11 | [reserved] | #d1d5db | 🪿 | normal |
| 35 | [reserved] | #d1d5db | 🪿 | normal |
| 51 | [reserved] | #d1d5db | 🪿 | normal |
| 57 | [reserved] | #d1d5db | 🪿 | normal |

All other squares follow the standard Goose/hazard/normal pattern.

---

## VISUAL DESIGN

**Color palette:**
- Base/board background: parchment `#faf3e0` (aged paper feel via CSS gradient)
- Accent: forest green `#2d6a4f`
- Gold: `#f4a261`
- Text: `#1c1917`

**Board:**
- Classic spiral layout, squares numbered 1–63 from outer ring to center
- Square size: ~80px desktop, ~48px mobile
- Square styles:
  - Normal: parchment `#faf3e0`, subtle border
  - Goose: golden `#f4a261`, 🪿 emoji, subtle shimmer animation
  - Bridge (6): teal `#0d9488`, 🌉
  - Inn (19): amber `#d97706`, 🍺
  - Well (31): blue `#2563eb`, 🪣
  - Maze (42): purple `#7c3aed`, 🌀
  - Prison (52): dark gray `#374151`, ⛓️
  - Death (58): black background, red glow, 💀
  - App square: app's `color` as background, icon + short name label
  - Square 63 (center): large golden burst, 👑
- Current turn player's reachable square: pulsing highlight

**Player tokens:**
- Circle with Nostr profile picture (fallback: colored letter)
- Each player gets a unique ring color: amber / teal / rose / violet / lime / sky
- Drop shadow
- Multiple tokens on same square: fan out with small offset (all visible)
- Movement animation: 300ms ease-out CSS transition per square, chained

**Dice:**
- Two CSS 3D dice (perspective transform, NOT images)
- Faces show SVG pip dots, white cube with black dots
- Roll animation: shake + spin 600ms, snap to result face
- Roll button: pulses in current player's ring color when it's your turn
- Display both dice + their sum

**Layout:**
- Desktop: board 70% left, right panel 30%
  - Right panel: player list (avatar + name + square + sats), active turn indicator
    (pulsing border), last 8 moves in event log, chat input
  - Top bar: room name, round counter, pot size ⚡
- Mobile: board full width top, collapsible tabs below (Players / Log / Chat)

**Feedback animations:**
- Goose square: wings-flap + "DOUBLE! 🪿" green toast
- Death: red screen flash + skull + "Back to start! 💀"
- App square: bottom sheet modal slides up (icon + description + effect)
- Bridge: token arc-animates directly to square 12
- Win: full-screen CSS confetti + winner avatar grows + sats fly to balance
- Bump: bumped token slides back with "bump!" badge

---

## FILE STRUCTURE

```
src/
  components/
    Board.tsx            ← spiral renderer, reads BoardConfig
    Square.tsx           ← single square: all types, hover, highlight
    PlayerToken.tsx      ← avatar + ring + movement animation
    Dice.tsx             ← 3D CSS dice + roll animation
    GameLog.tsx          ← event log (last 8 moves)
    PlayerPanel.tsx      ← right panel: players, turn indicator, sats
    AppSquareModal.tsx   ← bottom sheet on app square landing
    LobbyRoom.tsx        ← waiting room UI
    WinnerModal.tsx      ← confetti + winner + payout
    AdminPanel.tsx       ← board editor (/admin route)
  hooks/
    useGameRoom.ts       ← subscribe kind:30420
    useGameState.ts      ← subscribe kind:30421
    useBoardConfig.ts    ← subscribe kind:30422 (live updates)
    useGameServer.ts     ← publish RollRequests, receive DiceResults
    useLightning.ts      ← LNbits: invoice, verify, payout
  lib/
    gameLogic.ts         ← resolveMove(), applyEffect(), isGoose(),
                           computeNextPosition(), validateWin()
    boardLayout.ts       ← square N → {col, row} for spiral CSS grid
    nostrGame.ts         ← typed event builders for all game kinds
    defaultBoard.ts      ← hardcoded default 63-square BoardConfig
  pages/
    LobbyPage.tsx        ← open rooms list + create room
    GamePage.tsx         ← main game view
    AdminPage.tsx        ← board editor (Perry only)
  server/
    gameServer.ts        ← Node.js relay listener + game logic runner
    lightningService.ts  ← LNbits API wrapper
```

---

## SERVER SERVICE

Node.js process that runs alongside the app:
1. Connects to relay as server keypair (`agents/ganzenbord/nostr-key.json`)
2. Listens for `kind:20421` RollRequest events
3. XORs server_seed with player commitment → dice values
4. Runs full game logic (all rules, goose chains, bump, well/prison swap)
5. Publishes signed `kind:20422 DiceResult`
6. Publishes updated `kind:30421 GameState`
7. On win: publishes final GameState, triggers LNbits payout

Service: `ganzenbord-server`
Port: 3002
Systemd: `/etc/systemd/system/ganzenbord-server.service`

---

## LIGHTNING

Use LNbits subwallet per game room (same pattern as ZapHunt).
LNbits internal: `http://127.0.0.1:5000` — config already in `.env`.

- Entry: show Lightning invoice → verify zap receipt on relay → add player
- In-game sats: tracked in GameState `balances` field (no on-chain tx per move)
- Payout: create LNbits withdrawal or NWC payment to winner's Lightning address
- Free mode: `entry_fee_sats: 0` skips payment entirely

---

## ADMIN PANEL

Route: `/apps/ganzenbord/admin`
Guard: only Perry's pubkey may access:
`npub14qmyh789hq5t6u32dhr33qhlfm5dx70xf7l5tp8scmcm8ylcqkxqds0r58`

Features:
- Visual grid of all 63 squares with current config
- Click any square → edit drawer: type, app name, url, icon, color, effect
- "Add new Goosie Labs app" shortcut
- "Publish to Nostr" → publishes `kind:30422 BoardConfig` → all games update live

---

## QUALITY CHECKLIST (verify before calling done)

- [ ] All 63 squares render in correct spiral layout
- [ ] All hazard square effects work correctly
- [ ] Goose chaining works (consecutive geese keep moving)
- [ ] Overshoot bounce-back from 63 correct
- [ ] Bump displaces other player to your origin square
- [ ] First-move specials (6+3→26, 4+5→53) trigger only on first roll
- [ ] Well/Prison: player stuck until another lands and swaps
- [ ] Server signature on DiceResult verifiable by client
- [ ] BoardConfig change propagates live to all clients without refresh
- [ ] Admin panel rejects non-Perry pubkeys
- [ ] Mobile layout functional
- [ ] Zero TypeScript errors (`npm run build`)
- [ ] No private keys in frontend code

---

## THE VISION

This is not just a game. It's a **living map of Goosie Labs**.

Every app Perry ships becomes a square on the board.
Players are real Nostr identities.
Real sats change hands.
Wins are published to the Nostr timeline.
The board grows with the lab — forever.

🪿 Build the most beautiful Game of the Goose ever made.

---

## ▶ START HERE — STEP 1 of 9

**Build `src/lib/gameLogic.ts` — pure game logic, no UI, no Nostr.**

Implement and export these functions:

```typescript
// Returns the final square after applying all rules to a roll
export function computeNextPosition(
  currentSquare: number,
  die1: number,
  die2: number,
  isFirstRoll: boolean,
  board: SquareConfig[]
): MoveResult

// Resolves a single square's effect (called recursively for goose chains)
export function applyEffect(
  square: number,
  roll: number,
  board: SquareConfig[]
): EffectResult

// True if square is a Goose square
export function isGoose(square: number, board: SquareConfig[]): boolean

// True if player has won
export function validateWin(square: number): boolean

// Apply bump: returns new position for the bumped player
export function applyBump(
  landedSquare: number,
  occupantPreviousSquare: number
): number
```

Types to define in `src/lib/gameLogic.ts`:
- `MoveResult`: `{ finalSquare, effect, effectDetail, gooseChain: number[] }`
- `EffectResult`: `{ targetSquare, effect, effectDetail }`
- `SquareConfig`: the 63-square board config shape (import from defaultBoard.ts)

Also create `src/lib/defaultBoard.ts` with the hardcoded 63-square array.

Write the logic for ALL rules from the Game Rules section above.

When done: `npm run build` must pass. Commit: "step 1: game logic".
Then say **"Step 1 complete — ready for step 2"** and wait.
