---
name: lean-deps-architecture
description: Apps must be standalone — own locale files, own deps, no shared root dependencies unless unavoidable
metadata:
  type: feedback
---

Every Goosie Labs app should be as standalone as possible. The goal is easy distribution and independence.

**Rule:** Each app carries everything it needs in its own directory. No references up to `/var/www/goosielabs/` root unless there is no other way.

**Why:** Apps should be distributable, deployable independently, and not break when root-level things change.

**How to apply:**
- Locale files live in `apps/<name>/public/locales/` — not in a shared root
- i18n config, LanguageSwitcher, common.json all copied into each app
- Dependencies declared in each app's own `package.json`
- Shared things (like boilerplate) are copied on `newapp`, not imported by reference
- If an app truly needs a shared API (relay URL, mint URL) use env vars or the app's own config, not a hardcoded root path
