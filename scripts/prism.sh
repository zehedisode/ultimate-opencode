#!/bin/bash
# 🧠 PRISM 2.0 — Kişisel AI Evrim Sistemi
# Kullanım: prism <komut> [args]

set -euo pipefail
PRISM_DIR="$HOME/.opencode/prism"
mkdir -p "$PRISM_DIR"
PROFILE="$PRISM_DIR/profile.json"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

init_profile() {
    if [ -f "$PROFILE" ]; then
        echo -e "${YELLOW}⚠️  Profil zaten var. Güncelleniyor...${NC}"
    fi
    cat > "$PROFILE" << EOF
{
  "version": "2.0",
  "created": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "last_updated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "session_count": 0,
  "style": {
    "naming_convention": "unknown",
    "indentation": 2,
    "semicolons": true,
    "prefer_arrow_functions": false,
    "early_return": false,
    "max_line_length": 100
  },
  "frameworks": [],
  "languages": [],
  "learned_patterns": []
}
EOF
    echo -e "${GREEN}✅ PRISM profili oluşturuldu: $PROFILE${NC}"
}

case "${1:-help}" in
    init)
        init_profile
        ;;
    profile|p)
        if [ ! -f "$PROFILE" ]; then
            echo -e "${YELLOW}⚠️  Profil bulunamadı. Önce 'prism init' çalıştır.${NC}" >&2
            exit 1
        fi
        echo -e "${CYAN}🧠 PRISM 2.0 Profili:${NC}"
        python3 -m json.tool "$PROFILE" 2>/dev/null || cat "$PROFILE"
        ;;
    analyze|a)
        TARGET="${2:-.}"
        if [ ! -d "$TARGET" ]; then
            echo -e "${RED}❌ Geçersiz dizin: $TARGET${NC}" >&2
            exit 1
        fi
        echo -e "${CYAN}🔍 Analiz ediliyor: $TARGET${NC}"

        # Count files by language
        TS=$(find "$TARGET" -name '*.ts' -o -name '*.tsx' 2>/dev/null | wc -l)
        JS=$(find "$TARGET" -name '*.js' -o -name '*.jsx' 2>/dev/null | wc -l)
        PY=$(find "$TARGET" -name '*.py' 2>/dev/null | wc -l)
        GO=$(find "$TARGET" -name '*.go' 2>/dev/null | wc -l)
        RS=$(find "$TARGET" -name '*.rs' 2>/dev/null | wc -l)
        JAVA=$(find "$TARGET" -name '*.java' 2>/dev/null | wc -l)
        PHP=$(find "$TARGET" -name '*.php' 2>/dev/null | wc -l)

        # CamelCase vs snake_case detection
        CAMEL=$(grep -r 'const [a-z][a-zA-Z]* =' "$TARGET" --include='*.ts' --include='*.js' 2>/dev/null | wc -l)
        SNAKE=$(grep -r 'const [a-z_]* =' "$TARGET" --include='*.ts' --include='*.js' 2>/dev/null | wc -l)

        echo ""
        echo -e "${GREEN}📊 Analiz Sonuçları:${NC}"
        echo "  TypeScript: $TS dosya"
        echo "  JavaScript: $JS dosya"
        echo "  Python: $PY dosya"
        echo "  Go: $GO dosya"
        echo "  Rust: $RS dosya"
        echo "  Java: $JAVA dosya"
        echo "  PHP: $PHP dosya"
        echo "  camelCase: $CAMEL | snake_case: $SNAKE"

        # Update profile with detected data
        if [ -f "$PROFILE" ]; then
            local langs="[]"
            [ "$TS" -gt 0 ] && langs=$(echo "$langs" | jq '. + ["TypeScript"]')
            [ "$PY" -gt 0 ] && langs=$(echo "$langs" | jq '. + ["Python"]')
            [ "$GO" -gt 0 ] && langs=$(echo "$langs" | jq '. + ["Go"]')
            local naming="camelCase"
            [ "$SNAKE" -gt "$CAMEL" ] && naming="snake_case"

            local tmp=$(mktemp)
            jq ".languages = $langs | .style.naming_convention = \"$naming\" | .last_updated = \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\" | .session_count += 1" "$PROFILE" > "$tmp" && mv "$tmp" "$PROFILE"
        fi
        ;;
    suggest|s)
        FILE="${2:-}"
        if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
            echo -e "${RED}❌ Geçerli bir dosya belirt${NC}" >&2
            exit 1
        fi
        if [ ! -f "$PROFILE" ]; then
            echo -e "${YELLOW}⚠️  Profil yok. 'prism init' çalıştır.${NC}"
            exit 0
        fi
        LANG=$(jq -r '.style.naming_convention' "$PROFILE")
        echo -e "${CYAN}💡 PRISM Önerisi:${NC}"
        echo "  Dosya: $FILE"
        echo "  Stil: $LANG"
        echo "  Öneri: Bu dosyada ${LANG} isimlendirme kullan"
        ;;
    help|--help|-h)
        echo "🧠 PRISM 2.0 — Kişisel AI Evrim Sistemi"
        echo ""
        echo "Kullanım: prism <komut> [args]"
        echo ""
        echo "Komutlar:"
        echo "  init              Profil oluştur"
        echo "  profile, p        Profili göster"
        echo "  analyze <dizin>   Kod stilini analiz et"
        echo "  suggest <dosya>   Stil önerisi al"
        ;;
    *)
        echo -e "${RED}❌ Bilinmeyen komut: $1${NC}" >&2
        echo "Kullanım: prism <komut> [args]  (--help)" >&2
        exit 1
        ;;
esac
