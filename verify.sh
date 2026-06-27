#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
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

echo "=========================================="
echo "  🔍 Ultimate OpenCode - Doğrulama"
echo "=========================================="
echo ""

echo "📡 MCP Server:"
check "codegraph"         command -v codegraph
check "codebase-memory"   command -v codebase-memory-mcp
check "context7"          command -v context7-mcp

echo ""
echo "🔌 Plugin:"
for p in opencode-helicone-session opencode-gemini-auth opencode-gitlab-plugin opencode-poe-auth opencode-subagent-statusline opencode-websearch; do
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
check "Claude-BugHunter"  test -f ~/.config/opencode/skills/loop-engineering.md

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
