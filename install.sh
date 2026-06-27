#!/bin/bash
set -e

echo "=========================================="
echo "  🚀 Ultimate OpenCode - Kurulum"
echo "=========================================="
echo ""

# opencode var mı?
if ! command -v opencode &>/dev/null; then
    echo "❌ opencode bulunamadı! Önce opencode'u kur:"
    echo "   curl -fsSL https://opencode.ai/install | bash"
    exit 1
fi

echo "📁 Config dosyaları kopyalanıyor..."
mkdir -p ~/.config/opencode
cp -v config/opencode.jsonc ~/.config/opencode/ 2>/dev/null || true
cp -v config/opencode.json ~/.config/opencode/ 2>/dev/null || true
cp -v config/cost-guard.config.jsonc ~/.config/opencode/ 2>/dev/null || true
cp -v config/tui.jsonc ~/.config/opencode/ 2>/dev/null || true

echo ""
echo "📄 AGENTS.md kopyalanıyor..."
cp -v config/AGENTS.md ~/.config/opencode/AGENTS.md 2>/dev/null || true

echo ""
echo "🎯 Skills kopyalanıyor..."
mkdir -p ~/.config/opencode/skills
cp -v skills/*.md ~/.config/opencode/skills/ 2>/dev/null || true

echo ""
echo "👤 Agent personlar kopyalanıyor..."
mkdir -p ~/.config/opencode/agents
cp -r agents/* ~/.config/opencode/agents/ 2>/dev/null || true

echo ""
echo "⚡ Slash komutlar kopyalanıyor..."
mkdir -p ~/.config/opencode/commands
cp -v commands/*.md ~/.config/opencode/commands/ 2>/dev/null || true

echo ""
echo "👥 Council of High Intelligence kuruluyor..."
if [ -d "council/agents" ]; then
    mkdir -p ~/.claude/agents
    cp -v council/agents/*.md ~/.claude/agents/ 2>/dev/null || true
fi
if [ -d "council/council" ]; then
    mkdir -p ~/.claude/skills/council
    cp -rv council/council/* ~/.claude/skills/council/ 2>/dev/null || true
fi

echo ""
echo "📦 Plugin'ler yükleniyor..."
plugins=(
    "opencode-helicone-session"
    "opencode-gemini-auth"
    "opencode-gitlab-plugin"
    "opencode-poe-auth"
    "opencode-subagent-statusline"
    "opencode-websearch"
)
for p in "${plugins[@]}"; do
    echo "  → $p"
    opencode plugin "$p" -g 2>/dev/null || echo "  ⚠️  $p yüklenemedi, atlanıyor"
done

echo ""
echo "📡 MCP Server'lar yükleniyor..."
# codegraph
if ! command -v codegraph &>/dev/null; then
    echo "  → codegraph (55K⭐) npm install..."
    npm install -g @colbymchenry/codegraph 2>/dev/null || true
fi

# codebase-memory-mcp
if ! command -v codebase-memory-mcp &>/dev/null; then
    echo "  → codebase-memory-mcp (17K⭐) curl install..."
    curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash 2>/dev/null || true
fi

# context7
if ! command -v context7-mcp &>/dev/null; then
    echo "  → context7 (dökümantasyon MCP)..."
    npm install -g @upstash/context7-mcp 2>/dev/null || true
fi

# serena
if ! command -v serena &>/dev/null; then
    echo "  → serena (25K⭐) uv install..."
    which uv &>/dev/null || curl -LsSf https://astral.sh/uv/install.sh | bash
    uv tool install -p 3.13 serena-agent 2>/dev/null || true
fi

echo ""
echo "=========================================="
echo "  ✅ Ultimate OpenCode kuruldu!"
echo "=========================================="
echo ""
echo "📖 Kullanım:"
echo "  opencode                  # TUI'yi başlat"
echo "  /council <soru>           # 18 AI persona karar"
echo "  @python-expert <soru>     # Uzman subagent çağır"
echo "  /commit                   # commit mesajı yaz"
echo "  /review                   # kod review"
echo "  Ctrl+T                    # model variant değiştir"
echo "  Tab                       # build/plan arası geç"
echo ""
echo "📌 Not: codegraph için projende 'codegraph init' çalıştır"
echo "   Brave Search için BRAVE_API_KEY ortam değişkeni gerekli"
echo ""
