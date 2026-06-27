#!/bin/bash
# 🗑️ Ultimate OpenCode - Uninstaller
# Usage: ./uninstall.sh [--force] [--purge]

set -euo pipefail
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
FORCE=0; PURGE=0

for arg in "$@"; do
    case "$arg" in
        --force|-f) FORCE=1 ;;
        --purge|-p) PURGE=1 ;;
        --help|-h)
            echo "🗑️ Ultimate OpenCode - Uninstaller"
            echo ""
            echo "Usage: ./uninstall.sh [OPTION]"
            echo ""
            echo "Options:"
            echo "  --force, -f   Uninstall without confirmation"
            echo "  --purge, -p   Remove all backups and data"
            echo "  --help, -h    Show this help"
            exit 0
            ;;
    esac
done

echo -e "${YELLOW}========================================${NC}"
echo -e "${YELLOW}  🗑️ Ultimate OpenCode - Uninstaller ${NC}"
echo -e "${YELLOW}========================================${NC}"
echo ""

if [ "$FORCE" -eq 0 ]; then
    echo -n "⚠️  Uninstall Ultimate OpenCode? [y/N]: "
    read -r ans
    [[ "$ans" =~ ^[Nn] ]] && echo "Cancelled." && exit 0
fi

# What will be removed
echo -e "${CYAN}📋 Will remove:${NC}"
echo "  • ~/.config/opencode/ (config, skills, agents, commands, themes)"
echo "  • ~/.config/opencode/scripts/"
echo "  • ~/.opencode/atlas/"
echo "  • ~/.opencode/prism/"
echo "  • ~/.opencode/chamber/"
echo "  • ~/.opencode/echo/"
echo "  • ~/.claude/agents/council-*.md"
echo "  • ~/.claude/skills/council/"
echo ""

if [ "$FORCE" -eq 0 ]; then
    echo -n "Continue? [y/N]: "
    read -r ans2
    [[ "$ans2" =~ ^[Nn] ]] && echo "Cancelled." && exit 0
fi

# Opencode config
echo -n "  → opencode config ... "
if [ -d "$HOME/.config/opencode" ]; then
    rm -rf "$HOME/.config/opencode"
    echo -e "${GREEN}removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

# ATLAS
echo -n "  → ATLAS ... "
if [ -d "$HOME/.opencode/atlas" ]; then
    rm -rf "$HOME/.opencode/atlas"
    echo -e "${GREEN}removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

# PRISM
echo -n "  → PRISM profile ... "
if [ -d "$HOME/.opencode/prism" ]; then
    rm -rf "$HOME/.opencode/prism"
    echo -e "${GREEN}removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

# CHAMBER
echo -n "  → CHAMBER sessions ... "
if [ -d "$HOME/.opencode/chamber" ]; then
    rm -rf "$HOME/.opencode/chamber"
    echo -e "${GREEN}removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

# ECHO
echo -n "  → ECHO context ... "
if [ -d "$HOME/.opencode/echo" ]; then
    rm -rf "$HOME/.opencode/echo"
    echo -e "${GREEN}removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

# Council
echo -n "  → council agents ... "
COUNT=$(ls "$HOME/.claude/agents/council-"*.md 2>/dev/null | wc -l)
if [ "$COUNT" -gt 0 ]; then
    rm -f "$HOME/.claude/agents/council-"*.md
    echo -e "${GREEN}$COUNT files removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

echo -n "  → council skill ... "
if [ -d "$HOME/.claude/skills/council" ]; then
    rm -rf "$HOME/.claude/skills/council"
    echo -e "${GREEN}removed${NC}"
else
    echo -e "${YELLOW}not found${NC}"
fi

# Clean PATH
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    [ -f "$rc" ] && sed -i '/opencode\/scripts/d' "$rc" 2>/dev/null || true
done

# Purge: remove all backups
if [ "$PURGE" -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}🧹 Purge mode: Removing all backups...${NC}"
    BAK_COUNT=$(ls -d "$HOME/.config/opencode.backup_"* 2>/dev/null | wc -l)
    if [ "$BAK_COUNT" -gt 0 ]; then
        rm -rf "$HOME/.config/opencode.backup_"*
        echo -e "  ${GREEN}$BAK_COUNT backups removed${NC}"
    else
        echo -e "  ${YELLOW}no backups${NC}"
    fi
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ Ultimate OpenCode uninstalled! ${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📌 To reinstall: git clone and run ./install.sh"
[ "$PURGE" -eq 0 ] && echo "💾 Backups kept: ~/.config/opencode.backup_*"
echo ""
