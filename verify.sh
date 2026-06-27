#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
PASS=0; FAIL=0; WARN=0

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

warn() {
    local label=$1
    echo -e "  ${YELLOW}⚠️${NC} $label (atlandı)"
    ((WARN++))
}

echo "=========================================="
echo "  🔍 Ultimate OpenCode - Doğrulama"
echo "=========================================="
echo ""

# ---- Self-check mode ----
if [ "${1:-}" = "--self" ] || [ "${1:-}" = "-s" ]; then
    echo "📁 REPO BÜTÜNLÜĞÜ:"
    PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
    check "install.sh var"       test -f "$PROJECT_DIR/install.sh"
    check "rollback.sh var"      test -f "$PROJECT_DIR/rollback.sh"
    check "verify.sh var"        test -f "$PROJECT_DIR/verify.sh"
    check "README.md var"        test -f "$PROJECT_DIR/README.md"
    check "LICENSE var"          test -f "$PROJECT_DIR/LICENSE"
    check "Dockerfile var"       test -f "$PROJECT_DIR/Dockerfile"
    check ".gitignore var"       test -f "$PROJECT_DIR/.gitignore"

    echo ""
    echo "📂 DOSYA SAYILARI:"
    SKILLS=$(ls "$PROJECT_DIR/skills/"*.md 2>/dev/null | wc -l)
    AGENTS=$(find "$PROJECT_DIR/agents" -name '*.md' 2>/dev/null | wc -l)
    CMDS=$(ls "$PROJECT_DIR/commands/"*.md 2>/dev/null | wc -l)
    COUNCIL=$(ls "$PROJECT_DIR/council/agents/"*.md 2>/dev/null | wc -l)
    echo "  📄 $SKILLS skill"
    echo "  👤 $AGENTS agent"
    echo "  ⚡ $CMDS komut"
    echo "  👥 $COUNCIL council"

    check "En az 40 skill var"   test "$SKILLS" -ge 40
    check "En az 90 agent var"   test "$AGENTS" -ge 90
    check "En az 10 komut var"   test "$CMDS" -ge 10
    check "18 council agent var" test "$COUNCIL" -eq 18

    echo ""
    echo "🔍 KALİTE KONTROLÜ:"
    NO404=$(grep -rl "404: Not Found" "$PROJECT_DIR/skills/" "$PROJECT_DIR/agents/" "$PROJECT_DIR/commands/" 2>/dev/null | wc -l)
    check "404 içerik yok"       test "$NO404" -eq 0

    BAD_FM=$(for f in "$PROJECT_DIR/skills/"*.md; do head -1 "$f" 2>/dev/null; done | grep -v "^---$" | wc -l)
    check "Tüm skill'ler frontmatter'lı" test "$BAD_FM" -eq 0

    check "install.sh bash syntax" bash -n "$PROJECT_DIR/install.sh"
    check "rollback.sh bash syntax" bash -n "$PROJECT_DIR/rollback.sh"

    echo ""
    echo -e "=========================================="
    if [ "$FAIL" -eq 0 ]; then
        echo -e "  ${GREEN}✅ $PASS/$((PASS+FAIL)) başarılı${NC}"
        echo "  Repo sağlıklı!"
    else
        echo -e "  ${YELLOW}⚠️  $PASS başarılı, $FAIL hatalı${NC}"
    fi
    echo "=========================================="
    exit "$FAIL"
fi

# ---- JSON output ----
if [ "${1:-}" = "--json" ]; then
    SKILLS=$(ls ~/.config/opencode/skills/*.md 2>/dev/null | wc -l)
    AGENTS=$(find ~/.config/opencode/agents -name '*.md' 2>/dev/null | wc -l)
    CMDS=$(ls ~/.config/opencode/commands/*.md 2>/dev/null | wc -l)
    echo "{\"skills\":$SKILLS,\"agents\":$AGENTS,\"commands\":$CMDS,\"status\":\"ok\"}"
    exit 0
fi

# ---- Normal (installed) check ----
echo "📡 MCP Server:"
check "codegraph"         command -v codegraph
check "codebase-memory"   command -v codebase-memory-mcp
check "context7"          command -v context7-mcp

echo ""
echo "🔌 Plugin:"
for p in opencode-helicone-session opencode-gemini-auth opencode-gitlab-plugin opencode-poe-auth opencode-subagent-statusline opencode-websearch opencode-bridge opencode-cost-tracker; do
    check "$p" npm ls -g "$p" 2>/dev/null
done

echo ""
echo "🎯 Skills:"
check "caveman"           test -f ~/.config/opencode/skills/caveman.md
check "superpowers"       test -f ~/.config/opencode/skills/superpowers.md
check "karpathy-skills"   test -f ~/.config/opencode/skills/karpathy-skills.md
check "ponytail"          test -f ~/.config/opencode/skills/ponytail.md
check "planning"          test -f ~/.config/opencode/skills/planning-with-files.md
check "deliberation"      test -f ~/.config/opencode/skills/deliberation.md
check "prompt-master"     test -f ~/.config/opencode/skills/prompt-master.md
check "raptor"            test -f ~/.config/opencode/skills/raptor-security.md
check "OpenCLI"           test -f ~/.config/opencode/skills/opencli.md
check "cc-wf-studio"      test -f ~/.config/opencode/skills/cc-wf-studio.md
check "cursor-tools"      test -f ~/.config/opencode/skills/cursor-tools.md
check "repomix"           test -f ~/.config/opencode/skills/repomix.md

echo ""
echo "👤 Agents:"
check "103 agent personel" test "$(find ~/.config/opencode/agents -name '*.md' 2>/dev/null | wc -l)" -ge 100
check "14 slash komut"     test "$(ls ~/.config/opencode/commands/*.md 2>/dev/null | wc -l)" -ge 10

echo ""
echo "👥 Council:"
check "18 council agent"   test "$(ls ~/.claude/agents/council-*.md 2>/dev/null | wc -l)" -eq 18

echo ""
echo "🔧 CLI:"
check "serena"            command -v serena
check "opencli"           command -v opencli
check "gograph"           command -v gograph

echo ""
echo -e "=========================================="
if [ "$FAIL" -eq 0 ]; then
    echo -e "  ${GREEN}✅ $PASS/$((PASS+FAIL)) başarılı${NC}"
    echo "  Sorun yok!"
else
    echo -e "  ${YELLOW}⚠️  $PASS başarılı, $FAIL hatalı${NC}"
    echo "  Eksikleri gözden geçir."
fi
echo "=========================================="
