#!/bin/bash
# ⚡ CHAMBER — opencode Session Manager
# Kullanım: chamber <komut> [args]
# --json flag: JSON çıktı (machine-readable)

set -euo pipefail
CHAMBER_DIR="$HOME/.opencode/chamber"

# JSON mode
JSON=0; ARGS=()
for arg in "$@"; do [ "$arg" = "--json" ] && JSON=1 || ARGS+=("$arg"); done
set -- "${ARGS[@]}"
json_echo() { [ "$JSON" -eq 1 ] && echo "$@" || true; }
normal_echo() { [ "$JSON" -eq 0 ] && echo -e "$@" || true; }
mkdir -p "$CHAMBER_DIR"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

case "${1:-help}" in
    new)
        NAME="${2:-session-$(date +%s)}"
        mkdir -p "$CHAMBER_DIR/$NAME"
        echo "{\"created\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"name\":\"$NAME\",\"state\":\"active\"}" > "$CHAMBER_DIR/$NAME/meta.json"
        echo -e "${GREEN}✅ Session '$NAME' oluşturuldu${NC}"
        ;;
    list|ls)
        echo -e "${CYAN}📋 CHAMBER Sessions:${NC}"
        for d in "$CHAMBER_DIR"/*/; do
            [ -d "$d" ] || continue
            name=$(basename "$d")
            meta=$(cat "$d/meta.json" 2>/dev/null || echo '{"state":"unknown"}')
            state=$(echo "$meta" | grep -o '"state":"[^"]*"' | cut -d'"' -f4)
            created=$(echo "$meta" | grep -o '"created":"[^"]*"' | cut -d'"' -f4)
            snapshots=$(ls "$d"/snapshot-*.json 2>/dev/null | wc -l)
            echo -e "  ${CYAN}◉${NC} $name  ${YELLOW}$state${NC}  oluşturuldu:${created}  snapshot:${snapshots}"
        done
        ;;
    switch)
        NAME="$2"
        if [ -d "$CHAMBER_DIR/$NAME" ]; then
            echo "$NAME" > "$CHAMBER_DIR/.active"
            echo -e "${GREEN}✅ Session '$NAME' aktif${NC}"
        else
            echo -e "${RED}❌ Session '$NAME' bulunamadı${NC}" >&2
            exit 1
        fi
        ;;
    snapshot)
        NAME="${2:-$(cat "$CHAMBER_DIR/.active" 2>/dev/null || echo 'default')}"
        [ -d "$CHAMBER_DIR/$NAME" ] || mkdir -p "$CHAMBER_DIR/$NAME"
        SNAP="snapshot-$(date +%Y%m%d_%H%M%S)"
        {
            echo "{\"snapshot\":\"$SNAP\",\"name\":\"$NAME\",\"time\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"cwd\":\"$(pwd)\",\"env\":{}}"
        } > "$CHAMBER_DIR/$NAME/$SNAP.json"
        echo -e "${GREEN}✅ Snapshot '$SNAP' alındı${NC}"
        ;;
    restore)
        NAME="${2:-$(cat "$CHAMBER_DIR/.active" 2>/dev/null || echo 'default')}"
        # List snapshots
        echo -e "${CYAN}📸 Snapshots for '$NAME':${NC}"
        ls "$CHAMBER_DIR/$NAME"/snapshot-*.json 2>/dev/null | while read -r s; do
            echo "  $(basename "$s" .json)"
        done | head -10
        ;;
    parallel)
        CMD1="$2"
        CMD2="$3"
        echo -e "${YELLOW}🔄 Paralel çalıştırılıyor: $CMD1 | $CMD2${NC}"
        eval "$CMD1" &
        PID1=$!
        eval "$CMD2" &
        PID2=$!
        wait $PID1 $PID2
        echo -e "${GREEN}✅ Paralel işlem tamam${NC}"
        ;;
    merge)
        SRC="$2"
        DST="$3"
        if [ -d "$CHAMBER_DIR/$SRC" ] && [ -d "$CHAMBER_DIR/$DST" ]; then
            cp -r "$CHAMBER_DIR/$SRC"/* "$CHAMBER_DIR/$DST/" 2>/dev/null
            echo -e "${GREEN}✅ '$SRC' → '$DST' birleştirildi${NC}"
        else
            echo -e "${RED}❌ Session'lardan biri bulunamadı${NC}" >&2
            exit 1
        fi
        ;;
    help|--help|-h)
        echo "⚡ CHAMBER — opencode Session Manager"
        echo ""
        echo "Kullanım: chamber <komut> [args]"
        echo ""
        echo "Komutlar:"
        echo "  new <ad>         Yeni session oluştur"
        echo "  list, ls         Tüm session'ları listele"
        echo "  switch <ad>      Session değiştir"
        echo "  snapshot [ad]    State kaydet"
        echo "  restore [ad]     Snapshot'ları listele"
        echo "  parallel <c1> <c2>  Paralel çalıştır"
        echo "  merge <src> <dst>   Session birleştir"
        ;;
    *)
        echo -e "${RED}❌ Bilinmeyen komut: $1${NC}" >&2
        echo "Kullanım: chamber <komut> [args]  (--help)" >&2
        exit 1
        ;;
esac
