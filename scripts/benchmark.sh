#!/bin/bash
# 📊 Ultimate OpenCode Benchmark
# opencode performans test aracı
# Kullanım: ./scripts/benchmark.sh [--quick] [--json]

set -euo pipefail
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
QUICK=0; JSON=0
BASE="$(cd "$(dirname "$0")/.." && pwd)"

for arg in "$@"; do
    case "$arg" in
        --quick|-q) QUICK=1 ;;
        --json|-j) JSON=1 ;;
    esac
done

RESULTS="{}"
PASS=0; FAIL=0; TOTAL=0

bench() {
    local name="$1" cmd="$2" expected="$3"
    ((TOTAL++))
    echo -n "  → $name ... "
    local start=$(date +%s%N)
    if eval "$cmd" 2>/dev/null | grep -q "$expected"; then
        local end=$(date +%s%N)
        local ms=$(( (end - start) / 1000000 ))
        echo -e "${GREEN}✅ ${ms}ms${NC}"
        ((PASS++))
        RESULTS=$(echo "$RESULTS" | jq --arg n "$name" --arg ms "${ms}ms" '. + {($n): {"status":"pass","time":$ms}}')
    else
        echo -e "${RED}❌${NC}"
        ((FAIL++))
        RESULTS=$(echo "$RESULTS" | jq --arg n "$name" '. + {($n): {"status":"fail"}}')
    fi
}

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  📊 Ultimate OpenCode Benchmark${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# File count benchmarks
echo "📁 Dosya Sayıları:"
bench "Skills" "ls $BASE/skills/*.md 2>/dev/null | wc -l" "71"
bench "Agents" "find $BASE/agents -name '*.md' 2>/dev/null | wc -l" "103"
bench "Commands" "ls $BASE/commands/*.md 2>/dev/null | wc -l" "14"
bench "Council" "ls $BASE/council/agents/*.md 2>/dev/null | wc -l" "18"
bench "Scripts" "ls $BASE/scripts/*.sh 2>/dev/null | wc -l" "8"

# Quality benchmarks
echo ""
echo "🔍 Kalite Kontrolleri:"
bench "Agent frontmatter (name)" "grep -rl '^name:' $BASE/agents/ 2>/dev/null | wc -l" "103"
bench "Agent subagent_type" "grep -rl '^subagent_type:' $BASE/agents/ 2>/dev/null | wc -l" "103"
bench "Agent model" "grep -rl '^model:' $BASE/agents/ 2>/dev/null | wc -l" "103"
bench "Agent tools" "grep -rl '^tools:' $BASE/agents/ 2>/dev/null | wc -l" "103"
bench "Agent color" "grep -rl '^color:' $BASE/agents/ 2>/dev/null | wc -l" "103"
bench "Council SKILL.md referans" "grep -c 'council-' $BASE/council/council/SKILL.md 2>/dev/null" "18"
bench "404 içerik yok" "grep -rl '404: Not Found' $BASE/skills/ $BASE/agents/ $BASE/commands/ 2>/dev/null | wc -l" "0"

# Syntax checks
echo ""
echo "⚡ Syntax Kontrolleri:"
for f in install.sh uninstall.sh scripts/*.sh; do
    [ -f "$BASE/$f" ] && bench "bash -n $f" "bash -n $BASE/$f" "" || true
done

# Unique metrics
echo ""
echo "🏆 Benzersiz Metrikler:"
bench "Özgün özellik (PRISM)" "grep -l 'prism-v2' $BASE/skills/prism-v2.md 2>/dev/null | wc -l" "1"
bench "Özgün özellik (CHAMBER)" "grep -l 'chamber' $BASE/skills/chamber.md 2>/dev/null | wc -l" "1"
bench "Özgün özellik (ECHO)" "grep -l 'echo' $BASE/skills/echo.md 2>/dev/null | wc -l" "1"

echo ""
echo -e "=========================================="
if [ "$JSON" -eq 1 ]; then
    echo "$RESULTS" | jq '.total_benchmarks = $TOTAL | .passed = $PASS | .failed = $FAIL' --argjson TOTAL "$TOTAL" --argjson PASS "$PASS" --argjson FAIL "$FAIL"
else
    echo -e "  ${GREEN}✅ $PASS/$TOTAL test geçti${NC}"
    [ "$FAIL" -gt 0 ] && echo -e "  ${RED}❌ $FAIL test başarısız${NC}"
fi
echo "=========================================="
exit "$FAIL"
