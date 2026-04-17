#!/bin/bash
set -e

# Install wiki slash commands into Claude Code
# Usage: bash scripts/install-commands.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
COMMANDS_SRC="$REPO_ROOT/commands"
COMMANDS_DST="$HOME/.claude/commands"

mkdir -p "$COMMANDS_DST"

INSTALLED=0
for cmd_file in "$COMMANDS_SRC"/wiki-*.md; do
  [ -f "$cmd_file" ] || continue
  filename=$(basename "$cmd_file")
  cp "$cmd_file" "$COMMANDS_DST/$filename"
  echo "  Installed /$(basename "$filename" .md)"
  INSTALLED=$((INSTALLED + 1))
done

echo ""
echo "Installed $INSTALLED commands to $COMMANDS_DST"
echo "Restart Claude Code to use them."
