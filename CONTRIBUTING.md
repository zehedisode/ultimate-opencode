# Contributing

Thanks for contributing to Ultimate OpenCode! 🚀

## Environment Setup

```bash
git clone https://github.com/zehedisode/ultimate-opencode.git
cd ultimate-opencode
# No dependencies needed for development
# Run ./verify.sh --self to check integrity
```

## Adding a New Skill

1. Add `.md` file to `skills/`
2. Include YAML frontmatter (required):
   ```yaml
   ---
   name: skill-name
   description: "Category / Description — ⭐"
   ---
   ```
3. Add to skill table in `README.md`
4. Add to skill list in `AGENTS.md` (if present)
5. Add check to `verify.sh` (optional)
6. `install.sh` auto-copies all `.md` files from `skills/`

## Adding a New Agent

1. Add `.md` file under `agents/XX-category/`
2. Include YAML frontmatter:
   ```yaml
   ---
   name: agent-name
   subagent_type: agent-name
   model: claude-3-opus
   tools: ["Read","Grep","Glob","Bash","Edit","Write"]
   color: blue
   description: "Short description"
   ---
   ```
3. Update agent count in README

## Adding a New MCP Server

1. Add `install_mcp` call to `install.sh`
2. Add MCP definition to `config/opencode.jsonc`
3. Add to MCP table in README

## Code Standards

- Shell scripts: use `set -euo pipefail`
- All `.md` files must have YAML frontmatter
- No "404: Not Found" content allowed
- README counts must match actual file counts
- Agent frontmatter: name → subagent_type → model → tools → color → desc

## Verification

```bash
./verify.sh --self      # Repository integrity check
bash -n install.sh      # Bash syntax check
bats tests/test_basics.bats  # Run test suite
```

## PR Process

1. Descriptive branch name: `fix/issue-name` or `feature/new-feature`
2. Commit: `🔧 loop #N: description of changes`
3. Open PR and ensure `--self` validation passes
