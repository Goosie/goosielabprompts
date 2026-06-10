---
name: model_switching_guidelines
description: When to use Haiku vs Sonnet based on task complexity and cost
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6ddef35f-f47a-4e9d-8161-2033982a05e0
---

## Model switching strategy for Goosie Labs work

**Why:** Haiku is 4× cheaper ($0.80/$4 vs $3/$15 per M tokens) but less capable for reasoning-heavy work. Switch to Sonnet when complexity requires it.

### Use Haiku for (cheap & fast)
- File reads and edits (configs, scripts, simple refactors)
- Straightforward code generation (icons, templates, boilerplate)
- Audits and checklists (file structure, sync checks, lint-style work)
- Simple bash scripts and shell commands
- Documentation updates and writing
- Quick questions about code that's already clear
- Running existing tools and commands

**Signs Haiku is sufficient:** Task has clear steps, no hidden interdependencies, limited context needed.

### Switch to Sonnet for (capable reasoning)
- Architecture decisions for new apps or features
- Complex multi-file refactoring across interdependent code
- Deep debugging (tracing bugs through call chains, subtle interactions)
- Reasoning about system design or tradeoffs
- Spawning subagents (they re-read full context; better to use Sonnet upfront)
- Decisions that affect other code you haven't reviewed yet
- When you need to reason about "what could break if I change this?"

**Signs to switch:** "This is going to need me to think about X, Y, and Z together" or "I'm not sure what the impact will be."

### How to trigger the switch
- **Proactive:** Assistenty watches for complexity signals and suggests `/model sonnet` mid-conversation
- **Explicit:** You type `/model sonnet` any time you feel it's needed (no ask-first needed)
- **Reactive:** If Haiku gets stuck or keeps saying "I need to think about this more," switch then

### Cost awareness
Keep in mind:
- Long Haiku session = many small chats (cache misses between turns)
- One Sonnet session for a complex task = often cheaper than 3-4 Haiku sessions that hit limits
- If you find yourself asking "should I switch?", you probably should

**How to apply:** Assistenty defaults to suggesting Haiku for new sessions (cheap), but watches for the moment when complexity outpaces Haiku's reasoning and flags it proactively.
