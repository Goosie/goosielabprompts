#!/usr/bin/env bash
# sync.sh — syncs Goosie Labs server context to this repo for Claude web
set -eu

CONTEXT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="/home/deploy"
APPS_DIR="/var/www/goosielabs/apps"
MEMORY_DIR="$HOME_DIR/.claude/projects/-home-deploy/memory"

log() { echo "[$(date '+%H:%M:%S')] $*"; }

log "Starting context sync..."

# ── 1. Core instruction files ────────────────────────────────────────────────
cp "$HOME_DIR/CLAUDE.md"           "$CONTEXT_DIR/CLAUDE.md"
cp "$HOME_DIR/.claude/CLAUDE.md"   "$CONTEXT_DIR/ASSISTENTY.md"
cp "$HOME_DIR/todo.md"             "$CONTEXT_DIR/todo.md"

# ── 2. Memory files ──────────────────────────────────────────────────────────
if [ -d "$MEMORY_DIR" ]; then
  mkdir -p "$CONTEXT_DIR/memory"
  find "$MEMORY_DIR" -name "*.md" -exec cp {} "$CONTEXT_DIR/memory/" \;
  log "Memory files copied"
fi

# ── 3. APPS.md — live app overview ──────────────────────────────────────────
{
  echo "# Apps — $(date '+%Y-%m-%d %H:%M')"
  echo ""
  echo "| App | URL | Git |"
  echo "|-----|-----|-----|"
  for app in "$APPS_DIR"/*/; do
    name=$(basename "$app")
    [ -f "$app/.archived" ] && continue
    url="https://goosielabs.com/apps/$name"
    has_git="no"
    [ -d "$app/.git" ] && has_git="yes"
    echo "| $name | $url | $has_git |"
  done
} > "$CONTEXT_DIR/APPS.md"
log "APPS.md generated"

# ── 4. RECENT.md — git activity last 7 days ─────────────────────────────────
{
  echo "# Recent Changes — last 7 days ($(date '+%Y-%m-%d %H:%M'))"
  echo ""
  echo "## Server (home-deploy)"
  echo '```'
  recent=$(git -C "$HOME_DIR" log --oneline --since="7 days ago" 2>/dev/null || true)
  if [ -n "$recent" ]; then
    echo "$recent" | head -30
  else
    echo "(no recent commits)"
  fi
  echo '```'
  echo ""
  echo "## Apps"
  for app in "$APPS_DIR"/*/; do
    name=$(basename "$app")
    [ -f "$app/.archived" ] && continue
    [ ! -d "$app/.git" ] && continue
    recent=$(git -C "$app" log --oneline --since="7 days ago" 2>/dev/null || true)
    [ -z "$recent" ] && continue
    echo ""
    echo "### $name"
    echo '```'
    echo "$recent" | head -10
    echo '```'
  done
} > "$CONTEXT_DIR/RECENT.md"
log "RECENT.md generated"

# ── 5. Commit and push ───────────────────────────────────────────────────────
cd "$CONTEXT_DIR"
git add -A

if git diff --cached --quiet; then
  log "Nothing changed — skipping commit"
  exit 0
fi

git commit -m "sync: $(date '+%Y-%m-%d %H:%M:%S')" --no-gpg-sign
git push origin main
log "Pushed to GitHub"
