#!/bin/bash
# 🗑️ Ultimate OpenCode - Kaldırma Aracı
# Kullanım: ./uninstall.sh [--force] [--purge]

set -euo pipefail
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
FORCE=0; PURGE=0

for arg in "$@"; do
    case "$arg" in
        --force|-f) FORCE=1 ;;
        --purge|-p) PURGE=1 ;;
        --help|-h)
            echo "🗑️ Ultimate OpenCode - Kaldırma Aracı"
            echo ""
            echo "Kullanım: ./uninstall.sh [SEÇENEK]"
            echo ""
            echo "Seçenekler:"
            echo "  --force, -f   Onay sormadan kaldır"
            echo "  --purge, -p   Tüm yedekleri ve verileri sil"
            echo "  --help, -h    Bu yardım mesajı"
            exit 0
            ;;
    esac
done

echo -e "${YELLOW}========================================${NC}"
echo -e "${YELLOW}  🗑️ Ultimate OpenCode - Kaldırma ${NC}"
echo -e "${YELLOW}========================================${NC}"
echo ""

if [ "$FORCE" -eq 0 ]; then
    echo -n "⚠️  Ultimate OpenCode kaldırılsın mı? [E/h]: "
    read -r ans
    [[ "$ans" =~ ^[Hh] ]] && echo "İptal edildi." && exit 0
fi

# Kaldırılacaklar
echo -e "${CYAN}📋 Kaldırılacaklar:${NC}"
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
    echo -n "Devam edilsin mi? [E/h]: "
    read -r ans2
    [[ "$ans2" =~ ^[Hh] ]] && echo "İptal edildi." && exit 0
fi

# Opencode config
echo -n "  → opencode config ... "
if [ -d "$HOME/.config/opencode" ]; then
    rm -rf "$HOME/.config/opencode"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# Opencode scripts
echo -n "  → opencode scripts ... "
if [ -d "$HOME/.config/opencode/scripts" ]; then
    rm -rf "$HOME/.config/opencode/scripts"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# ATLAS
echo -n "  → ATLAS ... "
if [ -d "$HOME/.opencode/atlas" ]; then
    rm -rf "$HOME/.opencode/atlas"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# PRISM
echo -n "  → PRISM profili ... "
if [ -d "$HOME/.opencode/prism" ]; then
    rm -rf "$HOME/.opencode/prism"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# CHAMBER
echo -n "  → CHAMBER session'ları ... "
if [ -d "$HOME/.opencode/chamber" ]; then
    rm -rf "$HOME/.opencode/chamber"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# ECHO
echo -n "  → ECHO context ... "
if [ -d "$HOME/.opencode/echo" ]; then
    rm -rf "$HOME/.opencode/echo"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# Council
echo -n "  → council agent'ları ... "
COUNT=$(ls "$HOME/.claude/agents/council-"*.md 2>/dev/null | wc -l)
if [ "$COUNT" -gt 0 ]; then
    rm -f "$HOME/.claude/agents/council-"*.md
    echo -e "${GREEN}$COUNT dosya silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

echo -n "  → council skill ... "
if [ -d "$HOME/.claude/skills/council" ]; then
    rm -rf "$HOME/.claude/skills/council"
    echo -e "${GREEN}silindi${NC}"
else
    echo -e "${YELLOW}yok${NC}"
fi

# PATH'ten temizle
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    [ -f "$rc" ] && sed -i '/opencode\/scripts/d' "$rc" 2>/dev/null || true
done

# Purge: tüm yedekleri sil
if [ "$PURGE" -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}🧹 Purge modu: Tüm yedekler siliniyor...${NC}"
    BAK_COUNT=$(ls -d "$HOME/.config/opencode.yedek_"* 2>/dev/null | wc -l)
    if [ "$BAK_COUNT" -gt 0 ]; then
        rm -rf "$HOME/.config/opencode.yedek_"*
        echo -e "  ${GREEN}$BAK_COUNT yedek silindi${NC}"
    else
        echo -e "  ${YELLOW}yedek yok${NC}"
    fi
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  ✅ Ultimate OpenCode kaldırıldı! ${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "📌 Tekrar kurmak için: git clone ve ./install.sh"
[ "$PURGE" -eq 0 ] && echo "💾 Yedekler korundu: ~/.config/opencode.yedek_*"
echo ""
