#!/usr/bin/env bats
# Ultimate OpenCode BATs Test Suite

setup() {
    BASE="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
}

@test "install.sh syntax check" {
    run bash -n "$BASE/install.sh"
    [ "$status" -eq 0 ]
}

@test "uninstall.sh syntax check" {
    run bash -n "$BASE/uninstall.sh"
    [ "$status" -eq 0 ]
}

@test "verify.sh syntax check" {
    run bash -n "$BASE/verify.sh"
    [ "$status" -eq 0 ]
}

@test "All scripts have valid syntax" {
    for f in "$BASE/scripts/"*.sh; do
        run bash -n "$f"
        [ "$status" -eq 0 ] || { echo "❌ $f failed"; return 1; }
    done
}

@test "All skills have YAML frontmatter" {
    for f in "$BASE/skills/"*.md; do
        head -1 "$f" | grep -q '^---$' || { echo "❌ $f missing frontmatter"; return 1; }
    done
}

@test "All agents have required fields" {
    for f in $(find "$BASE/agents" -name '*.md'); do
        for field in name subagent_type model tools color; do
            grep -q "^$field:" "$f" || { echo "❌ $f missing $field"; return 1; }
        done
    done
}

@test "Council agent count is 18" {
    count=$(ls "$BASE/council/agents/"*.md 2>/dev/null | wc -l)
    [ "$count" -eq 18 ]
}

@test "No 404 content in skills" {
    run grep -rl "404: Not Found" "$BASE/skills/" "$BASE/agents/" "$BASE/commands/" 2>/dev/null
    [ -z "$output" ]
}

@test "README contains current skill count" {
    count=$(ls "$BASE/skills/"*.md 2>/dev/null | wc -l)
    grep -q "$count Skill" "$BASE/README.md" || { echo "❌ README doesn't show $count skills"; return 1; }
}

@test "All council SKILL.md refs match files" {
    for ref in $(grep -oP 'council-\w+' "$BASE/council/council/SKILL.md" | sort -u); do
        [ -f "$BASE/council/agents/$ref.md" ] || { echo "❌ $ref not found"; return 1; }
    done
}

@test "Config JSON is valid" {
    run python3 -c "import json; json.load(open('$BASE/config/opencode.json'))"
    [ "$status" -eq 0 ]
}

@test "Install.sh --version works" {
    run bash "$BASE/install.sh" --version
    [ "$status" -eq 0 ]
    [[ "$output" == *"Ultimate OpenCode"* ]]
}

@test "chamber script --help works" {
    run bash "$BASE/scripts/chamber.sh" --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"CHAMBER"* ]]
}
