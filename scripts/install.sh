#!/usr/bin/env bash
# SkillPilot — Installer
# Installs the skill and generates the initial routing config.
# Usage: bash install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$(dirname "$SCRIPT_DIR")/skills/skill-pilot"
SKILL_DST="${HOME}/.claude/skills/skill-pilot"

log() { echo "▸ $1"; }
ok() { echo "✓ $1"; }

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   SkillPilot — Installer              ║"
echo "║   智能任务路由 / Intelligent Task Router  ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# --- Step 1: Install Skill ---
log "Installing skill-pilot skill..."
mkdir -p "$SKILL_DST"
cp "$SKILL_SRC/SKILL.md" "$SKILL_DST/SKILL.md"
ok "Skill installed → $SKILL_DST"

# --- Step 2: Copy Scripts ---
log "Installing scripts..."
mkdir -p "$SKILL_DST/scripts"
cp "$SCRIPT_DIR/scan-tools.sh" "$SKILL_DST/scripts/scan-tools.sh"
chmod +x "$SKILL_DST/scripts/scan-tools.sh"
ok "Scripts installed → $SKILL_DST/scripts"

# --- Step 3: Run Scanner ---
log "Running tool scanner..."
bash "$SKILL_DST/scripts/scan-tools.sh"
ok "Routing config generated"

# --- Step 4: Verify ---
ROUTING_FILE="${HOME}/.claude/rules/common/skill-pilot.md"
if [[ -f "$ROUTING_FILE" ]]; then
  ok "Routing rules active → $ROUTING_FILE"
else
  echo "⚠ Routing file not found at $ROUTING_FILE"
  echo "  Run: bash $SKILL_DST/scripts/scan-tools.sh"
fi

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   ✅ Installation Complete!               ║"
echo "║                                          ║"
echo "║   Usage:                                 ║"
echo "║   • Just describe your task normally     ║"
echo "║   • Claude auto-routes to best tool      ║"
echo "║                                          ║"
echo "║   Re-scan after adding new skills:       ║"
echo "║   bash ~/.claude/skills/skill-pilot/   ║"
echo "║         scripts/scan-tools.sh            ║"
echo "╚══════════════════════════════════════════╝"
echo ""
