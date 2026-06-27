#!/bin/bash

set -euo pipefail
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
PWD="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.config/opencode.yedek_$(date +%Y%m%d_%H%M%S)"
TIMEOUT=30
TOTAL_STEPS=12; CURRENT=0

# ---- Help ----
if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    echo "🚀 Ultimate OpenCode Installer"
    echo ""
    echo "Kullanım: ./install.sh [SEÇENEK]"
    echo ""
    echo "Seçenekler:"
    echo "  --help, -h    Bu yardım mesajı"
    echo "  --dry-run     Hiçbir şey yüklemeden simüle et"
    echo "  --no-plugins  Plugin'leri atla"
    echo "  --no-mcp      MCP server'ları atla"
    echo "  --no-atlas    ATLAS'ı atla"
    echo "  --no-backup   Yedek almadan kur"
    echo "  --os          Sadece işletim sistemini göster"
    echo ""
    echo "Varsayılan: Tüm bileşenler kurulur"
    exit 0
fi

# ---- Dry Run ----
DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
    DRY_RUN=1
    echo -e "${YELLOW}🔍 Dry-run modu: Hiçbir şey yüklenmeyecek${NC}"
    echo ""
fi

# ---- OS Only ----
if [ "${1:-}" = "--os" ]; then
    case "$(uname -s)" in Linux)
        if [ -f /etc/arch-release ]; then echo "Arch Linux"
        elif [ -f /etc/debian_version ]; then echo "Debian/Ubuntu"
        elif [ -f /etc/fedora-release ]; then echo "Fedora"
        else echo "Linux"; fi
        ;;
    Darwin) echo "macOS" ;;
    *) echo "Bilinmeyen OS" ;;
    esac
    exit 0
fi

# ---- Parse Flags ----
SKIP_PLUGINS=0; SKIP_MCP=0; SKIP_ATLAS=0; SKIP_BACKUP=0
for arg in "$@"; do
    case "$arg" in
        --no-plugins) SKIP_PLUGINS=1 ;;
        --no-mcp) SKIP_MCP=1 ;;
        --no-atlas) SKIP_ATLAS=1 ;;
        --no-backup) SKIP_BACKUP=1 ;;
    esac
done

trap 'echo -e "${RED}❌ Hata!${NC}"; exit 1' ERR

# ---- Network Check ----
if ! curl -s --max-time 5 https://github.com >/dev/null 2>&1; then
    echo -e "${RED}❌ İnternet bağlantısı yok!${NC}"
    exit 1
fi

# ---- SELinux / AppArmor Uyarısı ----
if command -v getenforce &>/dev/null && [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
    echo -e "${YELLOW}⚠️  SELinux Enforcing modunda. MCP server'larda sorun yaşarsan:${NC}"
    echo "   sudo setsebool -P domain_can_mmap_files 1"
fi

# ---- NPM Destek Kontrol ----
NPM_CMD="npm"
if ! command -v npm &>/dev/null; then
    if command -v pnpm &>/dev/null; then NPM_CMD="pnpm"
    elif command -v yarn &>/dev/null; then NPM_CMD="yarn"
    else
        echo -e "${YELLOW}⚠️  npm bulunamadı! MCP server'lar manuel kurulmalı.${NC}"
        NPM_CMD=""
    fi
fi

# ---- OS Detection ----
detect_os() {
    case "$(uname -s)" in
        Linux)
            if [ -f /etc/arch-release ]; then echo "arch"
            elif [ -f /etc/debian_version ]; then echo "debian"
            elif [ -f /etc/fedora-release ]; then echo "fedora"
            else echo "linux"; fi
            ;;
        Darwin) echo "macos" ;;
        *) echo "unknown" ;;
    esac
}
OS=$(detect_os)

# ---- Progress Bar ----
progress() {
    local current=$1 total=$2 label=$3
    local pct=$((current * 100 / total))
    local filled=$((pct / 2))
    local empty=$((50 - filled))
    printf "\r  ${CYAN}[${GREEN}"
    printf '%*s' "$filled" | tr ' ' '█'
    printf "${CYAN}${NC}"
    printf '%*s' "$empty" | tr ' ' '░'
    printf "${CYAN}]${NC} %3d%% ${label}  " "$pct"
}

# ---- Curl with progress bar ----
curl_progress() {
    local url=$1 output=$2 label=$3
    echo -n "  → $label ... "
    curl -# --max-time 30 -L "$url" -o "$output" 2>/dev/null && echo -e "${GREEN}tamam${NC}" || echo -e "${YELLOW}atlandı${NC}"
}

# ---- Self-Update Check ----
self_update() {
    local remote latest
    remote=$(curl -s --max-time 5 "https://api.github.com/repos/zehedisode/ultimate-opencode/commits/main" 2>/dev/null | grep -o '"sha":"[a-f0-9]*"' | head -1 | grep -o '[a-f0-9]\{7\}' || echo "")
    latest=$(git -C "$PWD" rev-parse --short HEAD 2>/dev/null || echo "")
    if [ -n "$remote" ] && [ -n "$latest" ] && [ "$remote" != "$latest" ]; then
        echo -e "${YELLOW}⚠️  Yeni sürüm var! (${remote})${NC}"
        echo "   git pull ile güncelleyebilirsin."
        echo ""
    fi
}

# ---- Banner ----
echo -e "${CYAN}"
cat banner.txt 2>/dev/null || echo "Ultimate OpenCode - Kurulum"
echo -e "${NC}"

# ---- Self Update ----
self_update

# ---- Prerequisites ----
if ! command -v opencode &>/dev/null; then
    echo -e "${RED}❌ opencode bulunamadı!${NC}"
    echo "   curl -fsSL https://opencode.ai/install | bash"
    exit 1
fi
echo -e "${GREEN}✅ opencode $(opencode --version 2>/dev/null)${NC}"
echo ""

# ---- Dry Run: Sadece ne yapılacağını göster ----
if [ "$DRY_RUN" -eq 1 ]; then
    echo -e "${CYAN}📋 Yapılacaklar:${NC}"
    echo "  • Config dosyaları → ~/.config/opencode/"
    echo "  • $(ls "$PWD/skills/"*.md 2>/dev/null | wc -l) skill → ~/.config/opencode/skills/"
    echo "  • $(find "$PWD/agents" -name '*.md' 2>/dev/null | wc -l) agent → ~/.config/opencode/agents/"
    echo "  • $(ls "$PWD/commands/"*.md 2>/dev/null | wc -l) komut → ~/.config/opencode/commands/"
    echo "  • 18 council agent → ~/.claude/agents/"
    echo "  • 7 plugin (opencode plugin -g)"
    echo "  • 4 MCP server"
    echo "  • ATLAS 7 modül → ~/.opencode/atlas/"
    echo ""
    echo -e "${YELLOW}Dry-run tamam. Gerçek kurulum için --dry-run olmadan çalıştır.${NC}"
    exit 0
fi

# ---- Backup ----
if [ "$SKIP_BACKUP" -eq 0 ]; then
    echo -e "${YELLOW}💾 Yedek alınıyor...${NC}"
    mkdir -p "$BACKUP_DIR"
    if [ -d "$HOME/.config/opencode" ]; then
        cp -r "$HOME/.config/opencode"/* "$BACKUP_DIR/" 2>/dev/null || true
        echo -e "  → $BACKUP_DIR"
    fi
else
    echo -e "${YELLOW}💾 Yedek atlandı${NC}"
fi

# ---- Copy Config ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Config"
mkdir -p "$HOME/.config/opencode"
for f in "$PWD/config/"*; do
    [ -f "$f" ] && cp "$f" "$HOME/.config/opencode/" 2>/dev/null || true
done

# ---- Copy Skills ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Skills ($(ls "$PWD/skills/"*.md 2>/dev/null | wc -l) adet)"
mkdir -p "$HOME/.config/opencode/skills"
for f in "$PWD/skills/"*.md; do
    [ -f "$f" ] && cp "$f" "$HOME/.config/opencode/skills/" 2>/dev/null || true
done
SKILL_COUNT=$(ls "$HOME/.config/opencode/skills/"*.md 2>/dev/null | wc -l)

# ---- Copy Agents ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Agents"
mkdir -p "$HOME/.config/opencode/agents"
cp -r "$PWD/agents/"* "$HOME/.config/opencode/agents/" 2>/dev/null || true
AGENT_COUNT=$(find "$HOME/.config/opencode/agents" -name '*.md' 2>/dev/null | wc -l)

# ---- Copy Commands ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Commands"
mkdir -p "$HOME/.config/opencode/commands"
for f in "$PWD/commands/"*.md; do
    [ -f "$f" ] && cp "$f" "$HOME/.config/opencode/commands/" 2>/dev/null || true
done
CMD_COUNT=$(ls "$HOME/.config/opencode/commands/"*.md 2>/dev/null | wc -l)

# ---- Council ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Council (18 agent)"
if [ -d "$PWD/council/agents" ]; then
    mkdir -p "$HOME/.claude/agents"
    cp -v "$PWD/council/agents/"*.md "$HOME/.claude/agents/" 2>/dev/null || true
fi
if [ -d "$PWD/council/council" ]; then
    mkdir -p "$HOME/.claude/skills/council"
    cp -rv "$PWD/council/council/"* "$HOME/.claude/skills/council/" 2>/dev/null || true
fi
echo ""

# ---- Plugins ----
if [ "$SKIP_PLUGINS" -eq 0 ]; then
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Plugins"
mkdir -p "$HOME/.config/opencode"
plugins=(
    "opencode-helicone-session"
    "opencode-gemini-auth"
    "opencode-gitlab-plugin"
    "opencode-poe-auth"
    "opencode-subagent-statusline"
    "opencode-websearch"
    "opencode-bridge"
    "opencode-cost-tracker"
)
PLUGIN_OK=0; PLUGIN_FAIL=0
for p in "${plugins[@]}"; do
    echo -n "  → $p ... "
    if opencode plugin "$p" -g 2>/dev/null; then
        echo -e "${GREEN}OK${NC}"; ((PLUGIN_OK++))
    else
        echo -e "${YELLOW}atlandı${NC}"; ((PLUGIN_FAIL++))
    fi
done
echo -e "  ${GREEN}$PLUGIN_OK kuruldu${NC}${YELLOW}, $PLUGIN_FAIL atlandı${NC}"
else
    echo -e "${YELLOW}⏭️  Plugin'ler atlandı (--no-plugins)${NC}"
fi

# ---- MCP Servers ----
if [ "$SKIP_MCP" -eq 0 ]; then
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "MCP Servers"

npm_install() {
    if [ -n "${NPM_CMD:-}" ]; then
        timeout "$TIMEOUT" $NPM_CMD install -g "$1" 2>/dev/null
    else
        return 1
    fi
}

install_mcp() {
    local name=$1 stars=$2 cmd=$3 install_cmd=$4
    echo -n "  → $name ($stars⭐) ... "
    if command -v "$cmd" &>/dev/null; then
        echo -e "${GREEN}zaten var${NC}"
        return
    fi
    if timeout "$TIMEOUT" bash -c "$install_cmd" 2>/dev/null; then
        echo -e "${GREEN}kuruldu${NC}"
    else
        echo -e "${YELLOW}önerildi (manuel: ${install_cmd%%|*})${NC}"
    fi
}

install_mcp "codegraph"       "55K"  "codegraph"           'npm_install @colbymchenry/codegraph'
install_mcp "codebase-memory" "17K"  "codebase-memory-mcp" 'curl -fsSL --max-time 30 https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash'
install_mcp "context7"        "doc"  "context7-mcp"        'npm_install @upstash/context7-mcp'
install_mcp "filesystem"      "mcp"  "filesystem-mcp"      'npm_install @modelcontextprotocol/server-filesystem'
install_mcp "chrome-devtools" "44K"  "chrome-devtools-mcp" 'npx -y @anthropic/chrome-devtools-mcp --version'
echo ""
echo -e "${YELLOW}ℹ️  İsteğe bağlı MCP'ler:${NC}"
echo "   brave-search: npx -y @anthropic/brave-search-mcp-server"
else
    echo -e "${YELLOW}⏭️  MCP Server'lar atlandı (--no-mcp)${NC}"
fi

# ---- CLI Tools ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "CLI Tools"
for tool in \
    "bridle|431⭐|bridle" \
    "claude-mem|84K⭐|claude-mem" \
    "opencli|25K⭐|@jackwener/opencli"; do
    
    IFS='|' read -r cmd stars pkg <<< "$tool"
    echo -n "  → $cmd ($stars) ... "
    if command -v "$cmd" &>/dev/null; then
        echo -e "${GREEN}zaten var${NC}"
    else
        npm_install "$pkg" && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
    fi
done

# serena (special - needs uv)
if ! command -v serena &>/dev/null; then
    echo -n "  → serena (25K⭐) ... "
    which uv &>/dev/null || curl -LsSf https://astral.sh/uv/install.sh | bash >/dev/null 2>&1
    uv tool install -p 3.13 serena-agent >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
fi

# gograph (special - needs go)
if ! command -v gograph &>/dev/null; then
    echo -n "  → gograph (Go AST) ... "
    if command -v go &>/dev/null; then
        go install github.com/ozgurcd/gograph/cmd/gograph@latest >/dev/null 2>&1 && echo -e "${GREEN}kuruldu${NC}" || echo -e "${YELLOW}hata${NC}"
    else
        echo -e "${YELLOW}Go gerekli${NC}"
    fi
fi

# ---- ATLAS ----
if [ "$SKIP_ATLAS" -eq 0 ]; then
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "ATLAS"
mkdir -p "$HOME/.opencode/atlas"
if [ -d "$PWD/atlas" ]; then
    cp -r "$PWD/atlas/"* "$HOME/.opencode/atlas/" 2>/dev/null
    echo -e "  ${GREEN}✅ 7 modül kuruldu${NC}"
else
    echo -e "  ${YELLOW}⚠️ atlas klasörü bulunamadı${NC}"
fi
else
    echo -e "${YELLOW}⏭️  ATLAS atlandı (--no-atlas)${NC}"
fi

# ---- Themes ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Themes"
mkdir -p "$HOME/.config/opencode/themes"
for f in "$PWD/themes/"*; do
    [ -f "$f" ] && cp -v "$f" "$HOME/.config/opencode/themes/" 2>/dev/null || true
done

# ---- Add Scripts to PATH ----
if [ -f "$HOME/.bashrc" ] || [ -f "$HOME/.zshrc" ]; then
    SCRIPTS_DIR="$HOME/.config/opencode/scripts"
    mkdir -p "$SCRIPTS_DIR"
    for script in "$PWD/scripts/"*.sh; do
        [ -f "$script" ] && cp "$script" "$SCRIPTS_DIR/" 2>/dev/null || true
    done
    # Add to PATH if not already there
    PATH_LINE='export PATH="$PATH:$HOME/.config/opencode/scripts"'
    for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        [ -f "$rc" ] && grep -q "opencode/scripts" "$rc" 2>/dev/null || echo "$PATH_LINE" >> "$rc"
    done
    echo -e "  ${GREEN}✅ Scripts PATH'e eklendi${NC}"
fi

# ---- Restart Warning ----
echo ""
echo -e "${GREEN}"
echo "=========================================="
echo "  ✅ Ultimate OpenCode kuruldu!"
echo "=========================================="
echo -e "${NC}"
echo "📊 ÖZET:"
echo "  🎯 $SKILL_COUNT skill  👤 $AGENT_COUNT agent"
echo "  ⚡ $CMD_COUNT komut    🔌 $PLUGIN_OK plugin"
echo "  👥 18 council          🌍 7 atlas modül"
echo "  💾 Yedek: $BACKUP_DIR"
echo ""
echo "📖 KULLANIM:"
echo "  opencode              → TUI'yi başlat"
echo "  /council <soru>       → 18 AI persona"
echo "  @python-expert <soru> → uzman subagent"
echo "  /komut                → slash komut"
echo "  Ctrl+T → variant     Tab → agent"
echo ""
echo -e "${YELLOW}📌 codegraph için:    codegraph init"
echo "   ATLAS için:         atlas/init.sh"
echo "   Geri almak için:    cp -r $BACKUP_DIR/* ~/.config/opencode/${NC}"
echo ""
