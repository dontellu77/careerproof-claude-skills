#!/bin/bash
# CareerProof Skills Installer for Gemini CLI
# Usage: bash install.sh [--global]
#
# --global: Install to ~/.gemini/skills/ (available in all projects)
# Default: Install to ./.gemini/skills/ (current project only)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_SOURCE="$REPO_DIR/skills"

if [ "$1" = "--global" ]; then
  TARGET="$HOME/.gemini/skills"
  echo "Installing CareerProof skills globally to $TARGET"
else
  TARGET="./.gemini/skills"
  echo "Installing CareerProof skills to project: $TARGET"
fi

mkdir -p "$TARGET"

SKILL_COUNT=0
for skill_dir in "$SKILLS_SOURCE"/*/; do
  skill_name=$(basename "$skill_dir")
  dest="$TARGET/$skill_name"

  if [ -d "$dest" ]; then
    echo "  Updating: $skill_name"
    rm -rf "$dest"
  else
    echo "  Installing: $skill_name"
  fi

  cp -r "$skill_dir" "$dest"
  SKILL_COUNT=$((SKILL_COUNT + 1))
done

echo ""
echo "Installed $SKILL_COUNT skills successfully."
echo ""
echo "Next: Configure the CareerProof MCP server in your Gemini CLI settings."
echo ""
echo "Add this to your settings.json (usually ~/.gemini/settings.json):"
echo ""
cat "$SCRIPT_DIR/settings.json"
echo ""
echo "Replace YOUR_API_KEY_HERE with your CareerProof API key (cpk_...)."
echo "Get your API key at: https://careerproof.ai/dashboard/settings"
