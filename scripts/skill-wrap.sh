#!/bin/bash
# 🎯 Skill Wrapper — skill'leri listele, ara, bilgi göster
# Kullanım: skill <komut> [args]

set -euo pipefail
SKILLS_DIR="${SKILLS_DIR:-$(cd "$(dirname "$0")/../skills" && pwd)}"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

case "${1:-help}" in
    list|ls)
        echo -e "${CYAN}🎯 Ultimate OpenCode Skills (${GREEN}$(ls "$SKILLS_DIR"/*.md 2>/dev/null | wc -l)${NC}${CYAN})${NC}"
        echo ""
        for f in "$SKILLS_DIR"/*.md; do
            name=$(grep '^name:' "$f" | sed 's/name: *//')
            stars=$(grep -oP '[0-9]+⭐' "$f" || echo "")
            desc=$(grep '^description:' "$f" | sed 's/description: *//' | cut -d'"' -f2)
            echo -e "  ${GREEN}◉${NC} ${CYAN}$name${NC} ${YELLOW}$stars${NC}"
            echo "    $desc" | cut -c1-80
            echo ""
        done
        ;;
    search|s)
        TERM="${2:-}"
        [ -z "$TERM" ] && echo -e "${RED}❌ Arama terimi gerekli${NC}" >&2 && exit 1
        echo -e "${CYAN}🔍 '$TERM' aranıyor...${NC}"
        for f in "$SKILLS_DIR"/*.md; do
            if grep -qi "$TERM" "$f" 2>/dev/null; then
                name=$(grep '^name:' "$f" | sed 's/name: *//')
                stars=$(grep -oP '[0-9]+⭐' "$f" || echo "")
                echo -e "  ${GREEN}◉${NC} ${CYAN}$name${NC} ${YELLOW}$stars${NC}"
            fi
        done
        ;;
    info|i)
        NAME="${2:-}"
        [ -z "$NAME" ] && echo -e "${RED}❌ Skill adı gerekli${NC}" >&2 && exit 1
        f="$SKILLS_DIR/$NAME.md"
        [ ! -f "$f" ] && f="$SKILLS_DIR/${NAME}.md"
        [ ! -f "$f" ] && echo -e "${RED}❌ Skill '$NAME' bulunamadı${NC}" >&2 && exit 1
        echo -e "${CYAN}📄 $NAME${NC}"
        echo ""
        grep -v '^---$' "$f" | head -30
        ;;
    count|c)
        echo "$(ls "$SKILLS_DIR"/*.md 2>/dev/null | wc -l)"
        ;;
    help|--help|-h)
        echo "🎯 Skill Wrapper"
        echo ""
        echo "Kullanım: skill <komut> [args]"
        echo ""
        echo "Komutlar:"
        echo "  list, ls          Tüm skill'leri listele"
        echo "  search <terim>    Skill ara"
        echo "  info <ad>         Skill detayı"
        echo "  count             Skill sayısı"
        ;;
    *)
        echo -e "${RED}❌ Bilinmeyen komut: $1${NC}" >&2
        exit 1
        ;;
esac
