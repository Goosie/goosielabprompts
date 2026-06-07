---
name: feedback_blocky_time_source
description: "Blocky is the single source of block height — always read it from the relay, never from external APIs"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 1c53f308-f3c8-4d57-a758-aa36ccfb6ac3
---

Blocky sets the time. For anything that needs the current Bitcoin block height, read from the relay — not from mempool.space or any external API.

**Why:** Blocky is the V-Formation clock. It publishes its last-run state to the relay as kind 30078, d="vformation-lastrun", author=Blocky's pubkey. Perry was clear: "Blocky sets the time."

**How to apply:** Whenever block height is needed (goose age calculation, scheduling, timestamps), query the relay for Blocky's last-run event. In client-side JS: subscribe to kind 30078 with `#d: ["vformation-lastrun"]` from Blocky's pubkey (`d4e2e205c8e1437b40b635a88ca85c44f5f4b18539e8c09551d9ce0f200ff71b`).
