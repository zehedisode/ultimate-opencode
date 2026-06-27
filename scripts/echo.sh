#!/bin/bash
# 🔊 ECHO — Cross-Session Context Mirroring
# Kullanım: echo <komut> [mesaj]
# --json flag: JSON çıktı

set -euo pipefail
ECHO_DIR="$HOME/.opencode/echo"

JSON=0; ARGS=()
for arg in "$@"; do [ "$arg" = "--json" ] && JSON=1 || ARGS+=("$arg"); done
set -- "${ARGS[@]}"
json_echo() { [ "$JSON" -eq 1 ] && echo "$@" || true; }
mkdir -p "$ECHO_DIR"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
CONTEXT_DB="$ECHO_DIR/context.db"
DISCOVERIES="$ECHO_DIR/discoveries.json"
BUGS="$ECHO_DIR/bugs.json"
WARNINGS="$ECHO_DIR/warnings.json"

for f in "$DISCOVERIES" "$BUGS" "$WARNINGS"; do
    [ -f "$f" ] || echo '[]' > "$f"
done

log_context() {
    local type="$1" msg="$2"
    local entry="{\"type\":\"$type\",\"msg\":\"$msg\",\"time\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"agent\":\"${OPCODE_AGENT:-unknown}\",\"cwd\":\"$(pwd)\"}"
    echo "$entry" >> "$CONTEXT_DB"
    # Also update JSON store
    local store=""
    case "$type" in
        discovery) store="$DISCOVERIES" ;;
        bug) store="$BUGS" ;;
        warning) store="$WARNINGS" ;;
        *) return ;;
    esac
    local tmp=$(mktemp)
    jq ". += [$entry]" "$store" > "$tmp" && mv "$tmp" "$store" 2>/dev/null || true
}

case "${1:-help}" in
    share|s)
        [ -z "${2:-}" ] && echo -e "${RED}❌ Mesaj gerekli${NC}" >&2 && exit 1
        log_context "discovery" "$2"
        echo -e "${GREEN}🔊 Paylaşıldı:${NC} $2"
        ;;
    broadcast|b)
        [ -z "${2:-}" ] && echo -e "${RED}❌ Mesaj gerekli${NC}" >&2 && exit 1
        log_context "warning" "$2"
        echo -e "${YELLOW}📢 TÜM SESSION'LARA DUYURULDU:${NC} $2"
        ;;
    status|st)
        D=$(jq length "$DISCOVERIES" 2>/dev/null || echo 0)
        B=$(jq length "$BUGS" 2>/dev/null || echo 0)
        W=$(jq length "$WARNINGS" 2>/dev/null || echo 0)
        T=$(wc -l < "$CONTEXT_DB" 2>/dev/null || echo 0)
        json_echo "{\"discoveries\":$D,\"bugs\":$B,\"warnings\":$W,\"total\":$T}"
        normal_echo "${CYAN}🔊 ECHO Context:${NC} ${GREEN}Keşif:$D${NC} ${RED}Bug:$B${NC} ${YELLOW}Uyarı:$W${NC} Toplam:$T"
        ;;
    history|h)
        tail -20 "$CONTEXT_DB" 2>/dev/null | while read -r line; do
            type=$(echo "$line" | grep -o '"type":"[^"]*"' | cut -d'"' -f4)
            msg=$(echo "$line" | grep -o '"msg":"[^"]*"' | cut -d'"' -f4)
            time=$(echo "$line" | grep -o '"time":"[^"]*"' | cut -d'"' -f4 | sed 's/T/ /; s/Z//')
            echo -e "  [${time%?????}] ${CYAN}${type}${NC}: ${msg}"
        done
        ;;
    clear)
        : > "$CONTEXT_DB"
        echo '[]' > "$DISCOVERIES"
        echo '[]' > "$BUGS"
        echo '[]' > "$WARNINGS"
        echo -e "${GREEN}✅ ECHO context temizlendi${NC}"
        ;;
    help|--help|-h)
        echo "🔊 ECHO — Cross-Session Context Mirroring"
        echo ""
        echo "Kullanım: echo <komut> [mesaj]"
        echo ""
        echo "Komutlar:"
        echo "  share <msg>     Bilgi paylaş (keşif)"
        echo "  broadcast <msg>  Tüm session'lara duyur"
        echo "  status          Context durumunu göster"
        echo "  history         Geçmiş paylaşımlar"
        echo "  clear           Context temizle"
        ;;
    *)
        echo -e "${RED}❌ Bilinmeyen komut: $1${NC}" >&2
        echo "Kullanım: echo <komut> [mesaj]  (--help)" >&2
        exit 1
        ;;
esac
