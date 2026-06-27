#!/bin/bash
# ⭐ Skill Star Sayılarını GitHub API'den Güncelle
# Kullanım: ./scripts/sync-stars.sh

set -euo pipefail
SKILLS_DIR="$(cd "$(dirname "$0")/../skills" && pwd)"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  ⭐ Skill Star Sync ${NC}"
echo -e "${CYAN}========================================${NC}"

# Repo → skill name mapping (extended)
declare -A REPO_SKILLS=(
    ["ozgurcd/gograph"]=""
    ["colbymchenry/codegraph"]=""
    ["DeusData/codebase-memory-mcp"]="codebase-memory-skill"
    ["upstash/context7-mcp"]=""
    ["mckaywrigley/cursor-tools"]="cursor-tools"
    ["yamadatt/repomix"]="repomix"
    ["abi/screenshot-to-code"]="screenshot-to-code"
    ["langgenius/dify"]="dify"
    ["n8n-io/n8n"]="n8n"
    ["ChromeDevTools/chrome-devtools-mcp"]="chrome-devtools-mcp"
    ["astral-sh/uv"]="uv"
    ["BurntSushi/ripgrep"]="ripgrep"
    ["jesseduffield/lazygit"]="lazygit"
    ["punkpeye/awesome-mcp-servers"]="awesome-mcp-servers"
    ["pydantic/pydantic-ai"]="pydantic-ai"
    ["microsoft/agent-framework"]="microsoft-agent-framework"
    ["esengine/DeepSeek-Reasonix"]="deepseek-reasonix"
    ["Panniantong/Agent-Reach"]="agent-reach"
    ["wshobson/agents"]="wshobson-agents"
)

UPDATED=0
FAILED=0
SKIPPED=0

for repo in "${!REPO_SKILLS[@]}"; do
    skill_name="${REPO_SKILLS[$repo]}"
    [ -z "$skill_name" ] && continue

    skill_file="$SKILLS_DIR/$skill_name.md"
    [ ! -f "$skill_file" ] && continue

    echo -n "  → $repo ... "
    sleep 1  # Rate limit koruması
    response=$(curl -s --max-time 5 -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/$repo" 2>/dev/null || echo "")

    # Check for rate limiting
    if echo "$response" | grep -q "API rate limit"; then
        echo -e "${YELLOW}API rate limit!${NC}"
        echo -e "${YELLOW}  ⏳ 1 dakika bekle...${NC}"
        sleep 60
        response=$(curl -s --max-time 5 -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/$repo" 2>/dev/null || echo "")
    fi

    stars=$(echo "$response" | grep -o '"stargazers_count":[0-9]*' | grep -o '[0-9]*' || echo "")

    if [ -n "$stars" ] && [ "$stars" -gt 0 ]; then
        if [ "$stars" -ge 1000 ]; then
            formatted="$((stars / 1000))K"
        else
            formatted="$stars"
        fi
        if grep -qE '[0-9]+⭐' "$skill_file"; then
            sed -i "s/[0-9]*⭐/$formatted⭐/" "$skill_file"
            echo -e "${GREEN}[$formatted⭐]${NC}"
            ((UPDATED++))
        else
            echo -e "${YELLOW}[$formatted⭐] (etiketsiz)${NC}"
            ((SKIPPED++))
        fi
    else
        echo -e "${YELLOW}API hatası/boş${NC}"
        ((FAILED++))
    fi
done

echo ""
echo -e "${GREEN}✅ $UPDATED skill güncellendi${NC}"
[ "$SKIPPED" -gt 0 ] && echo -e "${CYAN}ℹ️  $SKIPPED skill etiketsiz (atlandı)${NC}"
[ "$FAILED" -gt 0 ] && echo -e "${YELLOW}⚠️  $FAILED skill güncellenemedi${NC}"
echo -e "${CYAN}========================================${NC}"
