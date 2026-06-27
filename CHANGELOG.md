# Changelog

## v1.7.0 (2026-06-28)
### 🔧 Loop #11: Master Launcher + BATs Tests + Docs + 6 New MCP Skills
- `scripts/opencode.sh` — master launcher (all scripts from one command)
- `tests/test_basics.bats` — 16 BATs tests (syntax, frontmatter, agent fields, council, counts)
- `docs/QUICKSTART.md`, `ARCHITECTURE.md`, `SCRIPTS.md` — comprehensive documentation
- 6 new opencode MCP skills: memory, filesystem, github, postgres, redis, brave
- README: 83 skills, 14+ MCP, 290+ files, 11 scripts
- English translation of README, CHANGELOG, CONTRIBUTING, SECURITY, AGENTS.md, docs/
- Total: **83 skills, 103 agents (5 fields), 11 scripts, 290+ files, 3 original inventions**

## v1.6.0 (2026-06-28)
### 🔧 Loop #10: Benchmark + CRON + Wrapper + 6 New Skills + Frontmatter Standard
- `scripts/cron-setup.sh` — weekly star sync CRON job
- `scripts/benchmark.sh` — opencode performance testing (--quick/--json)
- `scripts/skill-wrap.sh` — skill wrapper (list/search/info/count)
- Council `--members` validation: all SKILL.md references matched to agent files
- 103 agent frontmatter standardized: name→subagent→model→tools→color→desc
- 6 new skills: github-copilot(38K⭐), mcp-cli(4.7K⭐), gemini-cli(12K⭐), cursor-ide(21K⭐), opencode-plugins(1.5K⭐), ai-coding-agents(8.7K⭐)

## v1.5.0 (2026-06-28)
### 🔧 Loop #9: Uninstall + Validate + Mermaid + Colors + 6 Skills
- `uninstall.sh` — clean removal tool (--force/--purge)
- `scripts/validate-council.sh` — council agent validation (model, polarity, SKILL.md)
- README Mermaid architecture diagram
- 103 agents got `color` field (category-based: blue/red/green/cyan/magenta/yellow/purple)
- 18 council agents got `provider_affinity` field
- `install.sh --version` flag + backup rotation (keeps last 5 backups)
- 6 new skills: copilot-cli, aider(25K⭐), codex-cli(17K⭐), open-interpreter(55K⭐), continue(21K⭐), claude-code-cli(15K⭐)

## v1.4.0 (2026-06-28)
### 🔧 Loop #8: Star Sync + JSON Output + Badges + 5 New Skills
- `sync-stars.sh` improved: rate-limit protection, sleep, error handling
- `install.sh`: scripts added to PATH, bashrc/zshrc auto-config
- ATLAS: `performance.md` metrics module + `metrics/README.md`
- `chamber.sh`/`echo.sh`/`prism.sh`: --json output mode
- `config/opencode.jsonc`: chrome-devtools MCP + script references
- 5 new skills: agentic-threat-detection, opencode-mcp-hub, opencode-cost-optimizer, context-compressor, swe-agent(12K⭐)
- README: 8 badges (CI, Skills, Agents, Last Commit)

## v1.3.0 (2026-06-28)
### 🔧 Loop #7: 3 CLI Scripts + GitHub Templates + 6 Skills
- 103 agents got `tools` and `model` fields (category-based opus/sonnet + tool sets)
- `scripts/chamber.sh`, `echo.sh`, `prism.sh`, `sync-stars.sh`
- 6 new skills: pydantic-ai(18K⭐), ms-agent-framework(11K⭐), deepseek-reasonix(25K⭐), cc-switch(109K⭐), wshobson-agents(37K⭐), agent-reach(43K⭐)
- GitHub issue/PR templates + SECURITY.md + FUNDING.yml
- GitHub workflow: 4-field agent frontmatter, script dry-run

## v1.2.0 (2026-06-28)
### 🔧 Loop #6: 3 Original Inventions + 8 New Skills + Agent subagent_type
- 103 agents: `subagent_type` field added
- 18 council agents: model → claude-3-opus/sonnet
- **🧠 PRISM 2.0** (code style profiling) — original
- **⚡ CHAMBER** (session manager) — original
- **🔊 ECHO** (context mirroring) — original
- 8 new skills: dify(147K⭐), n8n(194K⭐), chrome-devtools-mcp(44K⭐), uv(40K⭐), ripgrep(51K⭐), lazygit(55K⭐), antigravity-awesome-skills(41K⭐), awesome-mcp-servers(89K⭐)

## v1.1.0 (2026-06-28)
### 🔧 Loop #5: Cleanup + Fixes + 7 New Popular Skills
- Skills directory cleanup (removed CLA, CHANGELOG, CLAUDE, CODE_OF_CONDUCT, AGENTS)
- 15 "404: Not Found" files filled with real content
- `install.sh`: duplicate `set -euo pipefail` removed, `self_update` no longer needs python3
- 7 new popular skills: cursor-tools(8.6K⭐), repomix(5.1K⭐), screenshot-to-code(64K⭐), claude-code-memory-mcp(3.2K⭐), claude-code-sync(1.2K⭐), mcp-router(890⭐), opencode-installer(450⭐)
- ATLAS: docs/ + team/sync added
- GitHub workflow: frontmatter validation, 404 check, JSON/JSONC validation
- systemd service expanded, bash completion extended
- Dockerfile multi-arch, verify.sh --self/--json modes

## v1.0.0 (2026-06-27)
### 🚀 Initial Release
- 4 MCP Servers (codegraph, codebase-memory, context7, filesystem)
- 41 Skills (categorized, frontmatter)
- 103 Agent Personas (10 categories)
- 14 Slash Commands
- 7 Plugins
- 18 Council of High Intelligence agents
- 🌍 ATLAS Project Intelligence System (7 modules)
- One-click installer (install.sh)
- Rollback (rollback.sh)
- Verification (verify.sh)
- OS Detection (Linux/macOS/Arch/Debian/Fedora)
- Auto-backup
- Network timeout management
- SELinux/AppArmor warning
- NPM/pnpm/yarn fallback
- Bash completion
- Dockerfile
- systemd service
- MIT License
- GitHub Pages website
