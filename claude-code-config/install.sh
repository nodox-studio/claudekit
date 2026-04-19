#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  Claude Code Config — Installer
#  By Guille Varela — Nodox Studio
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}  Claude Code Config — Installer${NC}"
echo -e "${CYAN}  By Guille Varela — Nodox Studio${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ── Check Claude Code ──────────────────────────
if ! command -v claude &> /dev/null; then
  echo -e "${RED}Claude Code not found.${NC}"
  echo "  Install it first: https://docs.anthropic.com/en/docs/claude-code"
  exit 1
fi
echo -e "${GREEN}✓${NC} Claude Code detected"

# ── Create directories ─────────────────────────
mkdir -p "$CLAUDE_DIR/commands"
echo -e "${GREEN}✓${NC} ~/.claude/commands/ ready"

# ── Copy slash commands ────────────────────────
COMMANDS_SRC="$SCRIPT_DIR/commands"
if [ -d "$COMMANDS_SRC" ]; then
  COPIED=0
  for file in "$COMMANDS_SRC"/*.md; do
    [ -f "$file" ] || continue
    name=$(basename "$file")
    if [ -f "$CLAUDE_DIR/commands/$name" ]; then
      echo -e "  ${YELLOW}⟳${NC} commands/$name already exists — skipped (rename yours to keep both)"
    else
      cp "$file" "$CLAUDE_DIR/commands/$name"
      COPIED=$((COPIED + 1))
      echo -e "  ${GREEN}+${NC} commands/$name"
    fi
  done
  echo -e "${GREEN}✓${NC} $COPIED slash command(s) installed"
else
  echo -e "${YELLOW}⚠${NC} No commands/ directory found — skipped"
fi

# ── Copy status line ──────────────────────────
if [ -f "$SCRIPT_DIR/statusline.sh" ]; then
  if [ -f "$CLAUDE_DIR/statusline.sh" ]; then
    echo -e "  ${YELLOW}⟳${NC} statusline.sh already exists — saved backup as statusline.sh.bak"
    cp "$CLAUDE_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh.bak"
  fi
  cp "$SCRIPT_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"
  chmod +x "$CLAUDE_DIR/statusline.sh"
  echo -e "${GREEN}✓${NC} statusline.sh installed"
else
  echo -e "${YELLOW}⚠${NC} No statusline.sh found — skipped"
fi

# ── RTK ────────────────────────────────────────
echo ""
if command -v rtk &> /dev/null; then
  RTK_VER=$(rtk --version 2>/dev/null || echo "unknown")
  echo -e "${GREEN}✓${NC} RTK already installed ($RTK_VER)"
  if rtk gain &> /dev/null; then
    echo -e "${GREEN}✓${NC} Verified: Rust Token Killer (correct RTK)"
  else
    echo -e "${YELLOW}⚠${NC} 'rtk gain' failed — you might have the wrong RTK (Rust Type Kit)."
    echo "  See: https://github.com/rtk-ai/rtk#installation"
  fi
else
  echo -e "${YELLOW}RTK (Rust Token Killer) not installed.${NC}"
  echo "  RTK saves 60-90% of tokens on CLI output sent to Claude."
  echo ""
  read -p "  Install RTK now? [Y/n] " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
    echo "  Installing RTK..."
    curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | bash
    if command -v rtk &> /dev/null; then
      echo -e "  ${GREEN}✓${NC} RTK installed successfully"
      echo "  Run 'rtk init -g' to set up Claude Code hooks"
    else
      echo -e "  ${RED}✗${NC} Installation failed. Install manually:"
      echo "    https://github.com/rtk-ai/rtk"
    fi
  else
    echo -e "  Skipped. Install later: ${CYAN}https://github.com/rtk-ai/rtk${NC}"
  fi
fi

# ── Summary ────────────────────────────────────
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Done!${NC}"
echo ""
echo "  Available slash commands in Claude Code:"
for file in "$CLAUDE_DIR/commands"/*.md; do
  [ -f "$file" ] || continue
  name=$(basename "$file" .md)
  echo -e "    ${CYAN}/$name${NC}"
done
echo ""
echo "  Next steps:"
echo "    1. Open Claude Code"
echo "    2. Try /savings or /workspace"
if ! command -v rtk &> /dev/null; then
  echo "    3. Install RTK for token savings: https://github.com/rtk-ai/rtk"
fi
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
