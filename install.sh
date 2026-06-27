#!/bin/bash

set -e
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

echo -e "${CYAN}"
echo "=========================================="
echo "  🚀 Ultimate OpenCode - Kurulum"
echo "=========================================="
echo -e "${NC}"

# opencode kontrol
if ! command -v opencode &>/dev/null; then
    echo -e "${RED}❌ opencode bulunamadı!${NC}"
    echo "   curl -fsSL https://opencode.ai/install | bash"
    exit 1
fi
echo -e "${GREEN}✅ opencode $(opencode --version 2>/dev/null)${NC}"
echo ""

# Config
echo -e "${YELLOW}📁 Config dosyaları${NC}"
mkdir -p ~/.config/opencode
for f in config/*; do
    cp -v "$f" ~/.config/opencode/ 2>/dev/null || true
done

echo ""
echo -e "${YELLOW}🎯 Skills (24 adet)${NC}"
mkdir -p ~/.config/opencode/skills
for f in skills/*.md; do
    cp -v "$f" ~/.config/opencode/skills/ 2>/dev/null || true
done

echo ""
echo -e "${YELLOW}👤 Agent personlar (103 adet)${NC}"
mkdir -p ~/.config/opencode/agents
cp -r agents/* ~/.config/opencode/agents/ 2>/dev/null || true

echo ""
echo -e "${YELLOW}⚡ Slash komutlar (14 adet)${NC}"
mkdir -p ~/.config/opencode/commands
cp -v commands/*.md ~/.config/opencode/commands/ 2>/dev/null || true

echo ""
echo -e "${YELLOW}👥 Council of High Intelligence (18 agent)${NC}"
if [ -d "council/agents" ]; then
    mkdir -p ~/.claude/agents
    cp -v council/agents/*.md ~/.claude/agents/ 2>/dev/null || true
fi
if [ -d "council/council" ]; then
    mkdir -p ~/.claude/skills/council
    cp -rv council/council/* ~/.claude/skills/council/ 2>/dev/null || true
fi

echo ""
echo -e "${YELLOW}📦 Plugin'ler${NC}"
plugins=(
    "opencode-helicone-session"
    "opencode-gemini-auth"
    "opencode-gitlab-plugin"
    "opencode-poe-auth"
    "opencode-subagent-statusline"
    "opencode-websearch"
)
for p in "${plugins[@]}"; do
    echo -n "  → $p ... "
    opencode plugin "$p" -g 2>/dev/null && echo -e "${GREEN}OK${NC}" || echo -e "${YELLOW}atlandı${NC}"
done

echo ""
echo -e "${YELLOW}📡 MCP Server'lar${NC}"

install_mcp() {
    local name=$1 stars=$2 cmd=$3 install_cmd=$4
    echo -n "  → $name ($stars⭐) ... "
    if command -v "$cmd" &>/dev/null; then
        echo -e "${GREEN}zaten var${NC}"
    else
        eval "$install_cmd" 2>/dev/null && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
    fi
}

install_mcp "codegraph"       "55K"  "codegraph"         'npm install -g @colbymchenry/codegraph'
install_mcp "codebase-memory" "17K"  "codebase-memory-mcp" 'curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash'
install_mcp "context7"        "doc"  "context7-mcp"      'npm install -g @upstash/context7-mcp'
install_mcp "filesystem"      "mcp"  "filesystem-mcp"    'npm install -g @modelcontextprotocol/server-filesystem'

echo ""
echo -e "${YELLOW}🔧 CLI Araçlar${NC}"
if ! command -v bridle &>/dev/null; then
    echo -n "  → bridle (431⭐) ... "
    npm install -g bridle >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
fi
if ! command -v claude-mem &>/dev/null; then
    echo -n "  → claude-mem (84K⭐) ... "
    npm install -g claude-mem >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
fi
if ! command -v serena &>/dev/null; then
    echo -n "  → serena (25K⭐) ... "
    which uv &>/dev/null || curl -LsSf https://astral.sh/uv/install.sh | bash >/dev/null 2>&1
    uv tool install -p 3.13 serena-agent >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
fi
if ! command -v opencli &>/dev/null; then
    echo -n "  → OpenCLI (25K⭐) ... "
    npm install -g @jackwener/opencli >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
fi
if ! command -v gograph &>/dev/null; then
    echo -n "  → gograph (Go AST) ... "
    go install github.com/ozgurcd/gograph/cmd/gograph@latest >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
fi

echo ""
echo -e "${YELLOW}🌍 ATLAS — Proje Bilinç Sistemi${NC}"
echo -n "  → Kuruluyor... "
mkdir -p ~/.opencode/atlas
if [ -d "atlas" ]; then
    cp -r atlas/* ~/.opencode/atlas/ 2>/dev/null
    echo -e "${GREEN}kuruldu (7 modül)${NC}"
else
    echo -e "${YELLOW}atlandı${NC}"
fi

echo ""
echo -e "${GREEN}"
echo "=========================================="
echo "  ✅ Ultimate OpenCode kuruldu!"
echo "=========================================="
echo -e "${NC}"
echo "📖 Kullan: opencode"
echo "👥  /council <soru>        — 18 AI persona"
echo "👤  @agent-adı             — uzman subagent"
echo "⚡  /komut                 — slash komut"
echo "⌨️   Ctrl+T → variant  |  Tab → agent"
echo ""
echo -e "${YELLOW}📌 codegraph için projende: codegraph init"
echo "   Brave Search API: BRAVE_API_KEY=<key> opencode${NC}"
echo ""
