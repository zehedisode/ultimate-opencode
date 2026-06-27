#!/bin/bash
# ⭐ Skill Star Sayılarını GitHub API'den Güncelle
# Kullanım: ./scripts/sync-stars.sh

set -euo pipefail
SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  ⭐ Skill Star Sync ${NC}"
echo -e "${CYAN}========================================${NC}"

# Repo → skill name mapping
declare -A REPO_SKILLS=(
    ["ozgurcd/gograph"]=""
    ["colbymchenry/codegraph"]=""
    ["DeusData/codebase-memory-mcp"]="codebase-memory-skill"
    ["upstash/context7-mcp"]=""
    ["modelcontextprotocol/server-filesystem"]=""
    ["mckaywrigley/cursor-tools"]="cursor-tools"
    ["yamadatt/repomix"]="repomix"
    ["abi/screenshot-to-code"]="screenshot-to-code"
    ["tact/opencode-installer"]="opencode-installer"
    ["langgenius/dify"]="dify"
    ["n8n-io/n8n"]="n8n"
    ["ChromeDevTools/chrome-devtools-mcp"]="chrome-devtools-mcp"
    ["astral-sh/uv"]="uv"
    ["BurntSushi/ripgrep"]="ripgrep"
    ["jesseduffield/lazygit"]="lazygit"
    ["sickn33/antigravity-awesome-skills"]="antigravity-awesome-skills"
    ["punkpeye/awesome-mcp-servers"]="awesome-mcp-servers"
    ["farion1231/cc-switch"]=""
)

UPDATED=0
FAILED=0

for repo in "${!REPO_SKILLS[@]}"; do
    skill_name="${REPO_SKILLS[$repo]}"
    [ -z "$skill_name" ] && continue

    skill_file="$SKILLS_DIR/$skill_name.md"
    [ ! -f "$skill_file" ] && continue

    echo -n "  → $repo ... "
    stars=$(curl -s --max-time 5 "https://api.github.com/repos/$repo" 2>/dev/null | grep -o '"stargazers_count":[0-9]*' | grep -o '[0-9]*' || echo "")

    if [ -n "$stars" ] && [ "$stars" -gt 0 ]; then
        # Format star count
        if [ "$stars" -ge 1000 ]; then
            formatted="$((stars / 1000))K"
        else
            formatted="$stars"
        fi
        # Update in skill file
        if grep -qE '[0-9]+⭐' "$skill_file"; then
            sed -i "s/[0-9]*⭐/$formatted⭐/" "$skill_file"
            echo -e "${GREEN}[$formatted⭐] güncellendi${NC}"
            ((UPDATED++))
        else
            echo -e "${YELLOW}[$formatted⭐] (⭐ etiketi yok, atlandı)${NC}"
        fi
    else
        echo -e "${YELLOW}API hatası${NC}"
        ((FAILED++))
    fi
done

echo ""
echo -e "${GREEN}✅ $UPDATED skill güncellendi${NC}"
[ "$FAILED" -gt 0 ] && echo -e "${YELLOW}⚠️  $FAILED skill güncellenemedi${NC}"
echo -e "${CYAN}========================================${NC}"
