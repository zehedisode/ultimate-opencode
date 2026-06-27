#!/bin/bash
# 👥 Council Member Validator
# SKILL.md'deki --members referanslarını gerçek council/agents/ dosyalarıyla eşleştirir

set -euo pipefail
BASE="$(cd "$(dirname "$0")/.." && pwd)"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
PASS=0; FAIL=0

check() {
    local label=$1; shift
    if "$@" &>/dev/null; then
        echo -e "  ${GREEN}✅${NC} $label"
        ((PASS++))
    else
        echo -e "  ${RED}❌${NC} $label"
        ((FAIL++))
    fi
}

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  👥 Council Member Validator ${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# Get all actual council agent files
echo "📁 Mevcut council agent dosyaları:"
for f in "$BASE/council/agents/"*.md; do
    name=$(basename "$f" .md | sed 's/^council-//')
    model=$(grep '^model:' "$f" 2>/dev/null | sed 's/model: *//')
    echo "  ◉ $name → $model"
done

echo ""
echo "🔍 SKILL.md referans doğrulama:"
SKILL_FILE="$BASE/council/council/SKILL.md"

# Check that all 18 council members are mentioned
for f in "$BASE/council/agents/"*.md; do
    name=$(basename "$f" .md)
    check "Agent '$name' SKILL.md'de var" grep -q "$name" "$SKILL_FILE"
done

echo ""
echo "📊 Model dağılımı:"
OPUS=$(grep -rl 'model: claude-3-opus' "$BASE/council/agents/" 2>/dev/null | wc -l)
SONNET=$(grep -rl 'model: claude-3-sonnet' "$BASE/council/agents/" 2>/dev/null | wc -l)
echo "  claude-3-opus: $OPUS"
echo "  claude-3-sonnet: $SONNET"

echo ""
echo "🔧 Polarity pair doğrulama:"
for f in "$BASE/council/agents/"*.md; do
    name=$(basename "$f" .md)
    if grep -q 'polarity_pairs' "$f" 2>/dev/null; then
        pairs=$(grep 'polarity_pairs' "$f" | grep -o '\[.*\]')
        echo "  ◉ $name: $pairs"
    else
        echo -e "  ${YELLOW}⚠️  $name: polarity_pairs eksik${NC}"
    fi
done

echo ""
echo -e "=========================================="
if [ "$FAIL" -eq 0 ]; then
    echo -e "  ${GREEN}✅ $PASS/$((PASS+FAIL)) başarılı${NC}"
else
    echo -e "  ${YELLOW}⚠️  $PASS başarılı, $FAIL hatalı${NC}"
fi
echo "=========================================="
