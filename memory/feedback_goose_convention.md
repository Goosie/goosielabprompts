---
name: feedback_goose_convention
description: ">> is the goose invocation prefix — two wings, not one"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ab00f9db-6f59-44f8-a3b4-cd68855945c5
---

Use `>>` to explicitly invoke a goose, not `@`.

**Why:** `@` conflicts with Claude Code's own UI (file references). Perry chose `>>` because "a goose has two wings, not one." Decided 2026-06-08.

**How to apply:**
- When Perry types `>>jurry overview` → execute `goosie jurry overview`
- When Perry types `>>healthy check` → execute `goosie healthy check`
- When Perry types `>>blocky schedule` → execute `goosie blocky schedule`
- `@` still works for backwards compatibility but `>>` is preferred
- For role geese: `>>transy`, `>>finny` etc. means play that role when responding
