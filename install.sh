#!/bin/bash

set -euo pipefail
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
PWD="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.config/opencode.backup_$(date +%Y%m%d_%H%M%S)"
TIMEOUT=30
TOTAL_STEPS=12; CURRENT=0
VERSION="1.7.0"

# ---- Version ----
if [ "${1:-}" = "--version" ] || [ "${1:-}" = "-v" ]; then
    echo "Ultimate OpenCode v$VERSION"
    echo "83 skills • 103 agents • 14 commands • 8 plugins • 18 council"
    exit 0
fi

# ---- Help ----
if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    echo "🚀 Ultimate OpenCode Installer"
    echo ""
    echo "Usage: ./install.sh [OPTION]"
    echo ""
    echo "Options:"
    echo "  --help, -h    Show this help"
    echo "  --dry-run     Simulate without installing"
    echo "  --no-plugins  Skip plugins"
    echo "  --no-mcp      Skip MCP servers"
    echo "  --no-atlas    Skip ATLAS"
    echo "  --no-backup   Skip backup"
    echo "  --os          Show OS only"
    echo "  --version, -v Show version"
    echo ""
    echo "Default: All components installed"
    exit 0
fi

# ---- Dry Run ----
DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
    DRY_RUN=1
    echo -e "${YELLOW}🔍 Dry-run mode: Nothing will be installed${NC}"
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
    *) echo "Unknown OS" ;;
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

trap 'echo -e "${RED}❌ Error!${NC}"; exit 1' ERR

# ---- Network Check ----
if ! curl -s --max-time 5 https://github.com >/dev/null 2>&1; then
    echo -e "${RED}❌ No internet connection!${NC}"
    exit 1
fi

# ---- SELinux / AppArmor Warning ----
if command -v getenforce &>/dev/null && [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
    echo -e "${YELLOW}⚠️  SELinux Enforcing mode. If MCP servers have issues:${NC}"
    echo "   sudo setsebool -P domain_can_mmap_files 1"
fi

# ---- NPM Support Check ----
NPM_CMD="npm"
if ! command -v npm &>/dev/null; then
    if command -v pnpm &>/dev/null; then NPM_CMD="pnpm"
    elif command -v yarn &>/dev/null; then NPM_CMD="yarn"
    else
        echo -e "${YELLOW}⚠️  npm not found! MCP servers must be installed manually.${NC}"
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

# ---- Curl with progress ----
curl_progress() {
    local url=$1 output=$2 label=$3
    echo -n "  → $label ... "
    curl -# --max-time 30 -L "$url" -o "$output" 2>/dev/null && echo -e "${GREEN}done${NC}" || echo -e "${YELLOW}skipped${NC}"
}

# ---- Self-Update Check ----
self_update() {
    local remote latest
    remote=$(curl -s --max-time 5 "https://api.github.com/repos/zehedisode/ultimate-opencode/commits/main" 2>/dev/null | grep -o '"sha":"[a-f0-9]*"' | head -1 | grep -o '[a-f0-9]\{7\}' || echo "")
    latest=$(git -C "$PWD" rev-parse --short HEAD 2>/dev/null || echo "")
    if [ -n "$remote" ] && [ -n "$latest" ] && [ "$remote" != "$latest" ]; then
        echo -e "${YELLOW}⚠️  New version available! (${remote})${NC}"
        echo "   Run 'git pull' to update."
        echo ""
    fi
}

# ---- Banner ----
echo -e "${CYAN}"
cat banner.txt 2>/dev/null || echo "Ultimate OpenCode - Installer"
echo -e "${NC}"

# ---- Self Update ----
self_update

# ---- Prerequisites ----
if ! command -v opencode &>/dev/null; then
    echo -e "${RED}❌ opencode not found!${NC}"
    echo "   curl -fsSL https://opencode.ai/install | bash"
    exit 1
fi
echo -e "${GREEN}✅ opencode $(opencode --version 2>/dev/null)${NC}"
echo ""

# ---- Dry Run: Show what will be done ----
if [ "$DRY_RUN" -eq 1 ]; then
    echo -e "${CYAN}📋 Will install:${NC}"
    echo "  • Config files → ~/.config/opencode/"
    echo "  • $(ls "$PWD/skills/"*.md 2>/dev/null | wc -l) skills → ~/.config/opencode/skills/"
    echo "  • $(find "$PWD/agents" -name '*.md' 2>/dev/null | wc -l) agents → ~/.config/opencode/agents/"
    echo "  • $(ls "$PWD/commands/"*.md 2>/dev/null | wc -l) commands → ~/.config/opencode/commands/"
    echo "  • 18 council agents → ~/.claude/agents/"
    echo "  • 8 plugins (opencode plugin -g)"
    echo "  • 4+ MCP servers"
    echo "  • ATLAS 7 modules → ~/.opencode/atlas/"
    echo "  • 11 scripts → ~/.config/opencode/scripts/ + PATH"
    echo ""
    echo -e "${YELLOW}Dry-run complete. Run without --dry-run to install.${NC}"
    exit 0
fi

# ---- Backup Rotation (keeps last 5) ----
rotate_backups() {
    local max=5
    local backups=($(ls -dt "$HOME/.config/opencode.backup_"* 2>/dev/null))
    local count=${#backups[@]}
    if [ "$count" -gt "$max" ]; then
        for ((i=max; i<count; i++)); do
            rm -rf "${backups[$i]}" 2>/dev/null || true
        done
    fi
}

# ---- Backup ----
if [ "$SKIP_BACKUP" -eq 0 ]; then
    rotate_backups
    echo -e "${YELLOW}💾 Creating backup...${NC}"
    mkdir -p "$BACKUP_DIR"
    if [ -d "$HOME/.config/opencode" ]; then
        cp -r "$HOME/.config/opencode"/* "$BACKUP_DIR/" 2>/dev/null || true
        echo -e "  → $BACKUP_DIR"
    fi
else
    echo -e "${YELLOW}💾 Backup skipped${NC}"
fi

# ---- Copy Config ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Config"
mkdir -p "$HOME/.config/opencode"
for f in "$PWD/config/"*; do
    [ -f "$f" ] && cp "$f" "$HOME/.config/opencode/" 2>/dev/null || true
done

# ---- Copy Skills ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Skills ($(ls "$PWD/skills/"*.md 2>/dev/null | wc -l) files)"
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
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Council (18 agents)"
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
)
PLUGIN_OK=0; PLUGIN_FAIL=0
for p in "${plugins[@]}"; do
    echo -n "  → $p ... "
    if opencode plugin "$p" -g 2>/dev/null; then
        echo -e "${GREEN}OK${NC}"; ((PLUGIN_OK++))
    else
        echo -e "${YELLOW}skipped${NC}"; ((PLUGIN_FAIL++))
    fi
done
echo -e "  ${GREEN}$PLUGIN_OK installed${NC}${YELLOW}, $PLUGIN_FAIL skipped${NC}"
else
    echo -e "${YELLOW}⏭️  Plugins skipped (--no-plugins)${NC}"
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
        echo -e "${GREEN}already exists${NC}"
        return
    fi
    if timeout "$TIMEOUT" bash -c "$install_cmd" 2>/dev/null; then
        echo -e "${GREEN}installed${NC}"
    else
        echo -e "${YELLOW}recommended (manual: ${install_cmd%%|*})${NC}"
    fi
}

install_mcp "codegraph"       "55K"  "codegraph"           'npm_install @colbymchenry/codegraph'
install_mcp "codebase-memory" "17K"  "codebase-memory-mcp" 'curl -fsSL --max-time 30 https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash'
install_mcp "context7"        "doc"  "context7-mcp"        'npm_install @upstash/context7-mcp'
install_mcp "filesystem"      "mcp"  "filesystem-mcp"      'npm_install @modelcontextprotocol/server-filesystem'
install_mcp "chrome-devtools" "44K"  "chrome-devtools-mcp" 'npx -y @anthropic/chrome-devtools-mcp --version'
echo ""
echo -e "${YELLOW}ℹ️  Optional MCPs:${NC}"
echo "   brave-search: npx -y @anthropic/brave-search-mcp-server"
else
    echo -e "${YELLOW}⏭️  MCP Servers skipped (--no-mcp)${NC}"
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
        echo -e "${GREEN}already exists${NC}"
    else
        npm_install "$pkg" && echo -e "${GREEN}installed${NC}" || echo -e "${YELLOW}error${NC}"
    fi
done

# serena (special - needs uv)
if ! command -v serena &>/dev/null; then
    echo -n "  → serena (25K⭐) ... "
    which uv &>/dev/null || curl -LsSf https://astral.sh/uv/install.sh | bash >/dev/null 2>&1
    uv tool install -p 3.13 serena-agent >/dev/null 2>&1 && echo -e "${GREEN}installed${NC}" || echo -e "${YELLOW}error${NC}"
fi

# gograph (special - needs go)
if ! command -v gograph &>/dev/null; then
    echo -n "  → gograph (Go AST) ... "
    if command -v go &>/dev/null; then
        go install github.com/ozgurcd/gograph/cmd/gograph@latest >/dev/null 2>&1 && echo -e "${GREEN}installed${NC}" || echo -e "${YELLOW}error${NC}"
    else
        echo -e "${YELLOW}Go required${NC}"
    fi
fi

# ---- Add Scripts to PATH ----
if [ -f "$HOME/.bashrc" ] || [ -f "$HOME/.zshrc" ]; then
    SCRIPTS_DIR="$HOME/.config/opencode/scripts"
    mkdir -p "$SCRIPTS_DIR"
    for script in "$PWD/scripts/"*.sh; do
        [ -f "$script" ] && cp "$script" "$SCRIPTS_DIR/" 2>/dev/null || true
    done
    PATH_LINE='export PATH="$PATH:$HOME/.config/opencode/scripts"'
    for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        [ -f "$rc" ] && grep -q "opencode/scripts" "$rc" 2>/dev/null || echo "$PATH_LINE" >> "$rc"
    done
    echo -e "  ${GREEN}✅ Scripts added to PATH${NC}"
fi

# ---- ATLAS ----
if [ "$SKIP_ATLAS" -eq 0 ]; then
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "ATLAS"
mkdir -p "$HOME/.opencode/atlas"
if [ -d "$PWD/atlas" ]; then
    cp -r "$PWD/atlas/"* "$HOME/.opencode/atlas/" 2>/dev/null
    echo -e "  ${GREEN}✅ 7 modules installed${NC}"
else
    echo -e "  ${YELLOW}⚠️ atlas directory not found${NC}"
fi
else
    echo -e "${YELLOW}⏭️  ATLAS skipped (--no-atlas)${NC}"
fi

# ---- Themes ----
((CURRENT++)); progress $CURRENT $TOTAL_STEPS "Themes"
mkdir -p "$HOME/.config/opencode/themes"
for f in "$PWD/themes/"*; do
    [ -f "$f" ] && cp -v "$f" "$HOME/.config/opencode/themes/" 2>/dev/null || true
done

# ---- Restart Warning ----
echo ""
echo -e "${GREEN}"
echo "=========================================="
echo "  ✅ Ultimate OpenCode installed!"
echo "=========================================="
echo -e "${NC}"
echo "📊 SUMMARY:"
echo "  🎯 $SKILL_COUNT skills  👤 $AGENT_COUNT agents"
echo "  ⚡ $CMD_COUNT commands  🔌 $PLUGIN_OK plugins"
echo "  👥 18 council          🌍 7 atlas modules"
echo "  💾 Backup: $BACKUP_DIR"
echo ""
echo "📖 USAGE:"
echo "  opencode              → Launch TUI"
echo "  /council <question>   → 18 AI personas"
echo "  @python-expert        → Expert subagent"
echo "  /command              → Slash command"
echo "  Ctrl+T → variant      Tab → agent"
echo ""
echo -e "${YELLOW}📌 codegraph:        codegraph init"
echo "   ATLAS:             atlas/init.sh"
echo "   Restore:           cp -r $BACKUP_DIR/* ~/.config/opencode/"
echo "   Uninstall:         ./uninstall.sh"
echo "   Scripts:           chamber/echo/prism${NC}"
echo ""
