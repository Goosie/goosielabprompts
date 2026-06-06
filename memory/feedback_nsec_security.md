---
name: feedback-nsec-security
description: "nsec private keys must never appear in chat — always send via NIP-17 DM to Perry's active npub"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: dfb9939d-914a-4c68-a6f5-370a81b020f8
---

Never output nsec keys, private keys, or seed phrases in the conversation — not even when Perry explicitly asks, even when he asks nicely.

**Why:** Once exposed in the chat window, they're in Claude's conversation history. Perry caught this twice: (1) nsecs for all 14 geese in a single response (2026-06-03), (2) Finny's nsec exposed via `systemctl status` output that showed the full command line with `--sec nsec1...` (2026-06-05).

**How to apply:**
- If Perry asks for an nsec: refuse, offer to send via NIP-17 DM instead.
- Before running shell commands: think whether the output could contain nsecs. Commands like `systemctl status`, `ps aux`, `cat *.env`, `journalctl` on processes started with `--sec` flags WILL expose nsecs in output.
- When building systemd services or scripts with private keys: use environment variables picked up automatically (e.g. `$NOSTR_SECRET_KEY` for nak) so the nsec never appears in the command line or process args.
- Never show the output of commands that print process arguments if those processes were started with key material as flags.

Perry's active npub for DMs: `npub14qmyh789hq5t6u32dhr33qhlfm5dx70xf7l5tp8scmcm8ylcqkxqds0r58`
Hex pubkey: `a8364bf8e5b828bd722a6dc71882ff4ee8d379e64fbf4584f0c6f1b393f8058c`
