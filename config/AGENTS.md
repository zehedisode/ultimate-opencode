<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool**: `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow.
- **Shell**: `codegraph explore "<symbol names or question>"` prints the same output.
<!-- CODEGRAPH_END -->

<!-- codebase-memory-mcp:start -->
## codebase-memory-mcp (17K⭐)

Code intelligence knowledge graph. 14 MCP tools.

**Priority**: `search_graph` → `trace_path` → `get_code_snippet` → `query_graph` → `get_architecture` → `detect_changes`

**Examples**:
- `search_graph(name_pattern=".*Handler.*")` — find handlers
- `trace_path(function_name="main", direction="inbound")` — who calls
- `query_graph('MATCH (f:Function) WHERE NOT EXISTS { (f)<-[:CALLS]-() } RETURN f.name')` — dead code
<!-- codebase-memory-mcp:end -->

> 💡 All 103 agents now include `tools`, `model`, and `color` fields. Agents are categorized by opus/sonnet per domain.
>
> 🆕 **PRISM 2.0** — code style profiling. **CHAMBER** — multi-session manager. **ECHO** — cross-session context mirroring.

## 🛠️ All Tools Used in This Project

### 📡 MCP Servers
| Tool | Purpose |
|---|---|
| **codegraph_explore** | Code knowledge graph — source + call paths in one query |
| **search_graph / trace_path** | Semantic code search and call chain |

### ⚡ Scripts (11 total)
| Script | Purpose |
|---|---|
| `chamber.sh` | Session manager — `chamber new/list/snapshot/parallel` |
| `echo.sh` | Context mirroring — `echo share/broadcast/status` |
| `prism.sh` | Code style profiling — `prism init/analyze/suggest` |
| `sync-stars.sh` | Sync star counts from GitHub API |
| `benchmark.sh` | Performance testing |
| `validate-council.sh` | Council member validation |
| `skill-wrap.sh` | Skill wrapper |
| `cron-setup.sh` | Weekly CRON setup |
| `opencode.sh` | Master launcher |

### 🎯 Skills (Categorized)

**⚡ Token & Performance**: caveman (%65 token savings), ponytail (senior dev thinking), context-compressor

**🧠 AI Frameworks**: ECC (222K⭐), superpowers (239K⭐), claude-mem (84K⭐), ruflo (61K⭐), get-shit-done (64K⭐), graphify (72K⭐), pydantic-ai (18K⭐), swe-agent (12K⭐)

**📐 Code Quality**: karpathy-skills (183K⭐), gstack (117K⭐), arc-kit (2K⭐)

**🛡️ Security**: Claude-BugHunter (3.1K⭐), raptor-security (3.2K⭐), hol-guard (372⭐), agentic-threat-detection (4.8K⭐)

**🔧 Development**: planning-with-files (24K⭐), ospec (555⭐), OpenCLI (25K⭐), SocratiCode (3K⭐), prompt-master (9.8K⭐), deliberation (107⭐), memorix (519⭐), cc-wf-studio (5.2K⭐), opencode-swarm (369⭐), bridle (431⭐)

**🎨 Design/Docs**: serena (25K⭐), vercel-skills (23K⭐), openpets (838⭐), agentify-desktop (452⭐)

**🔌 Integration**: AIClient2API (8.3K⭐), codebase-memory-skill, firecrawl-mcp (6.7K⭐), Chrome DevTools MCP (44K⭐)

**📚 Reference**: awesome-free-llm-apis (5.3K⭐), ask-user-questions, ultimate-opencode

**🆕 Loop #5**: cursor-tools (8.6K⭐), claude-code-memory-mcp (3.2K⭐), repomix (5.1K⭐), screenshot-to-code (64K⭐), claude-code-sync (1.2K⭐), mcp-router (890⭐), opencode-installer (450⭐)

**🆕 Loop #6**: PRISM 2.0 (original), CHAMBER (original), ECHO (original), dify (147K⭐), n8n (194K⭐), chrome-devtools-mcp (44K⭐), uv (40K⭐), ripgrep (51K⭐), lazygit (55K⭐), antigravity-awesome-skills (41K⭐), awesome-mcp-servers (89K⭐)

**🆕 Loop #7**: pydantic-ai (18K⭐), microsoft-agent-framework (11K⭐), deepseek-reasonix (25K⭐), cc-switch (109K⭐), wshobson-agents (37K⭐), agent-reach (43K⭐)

**🆕 Loop #8**: agentic-threat-detection (4.8K⭐), opencode-mcp-hub (2.1K⭐), opencode-cost-optimizer (976⭐), context-compressor (3.4K⭐), swe-agent (12K⭐)

**🆕 Loop #9**: copilot-cli (4.3K⭐), aider (25K⭐), codex-cli (17K⭐), open-interpreter (55K⭐), continue (21K⭐), claude-code-cli (15K⭐)

**🆕 Loop #10**: github-copilot (38K⭐), mcp-cli (4.7K⭐), gemini-cli (12K⭐), cursor-ide (21K⭐), opencode-plugins (1.5K⭐), ai-coding-agents (8.7K⭐)

**🆕 Loop #11**: opencode-mcp-memory, opencode-mcp-filesystem, opencode-mcp-github, opencode-mcp-postgres, opencode-mcp-redis, opencode-mcp-brave

### 👥 Council of High Intelligence
`/council <question>` — 18 AI personas deliberate.
Full reference: `council/council/SKILL.md`
- `--quick` fast, `--duo` dual, `--triad <domain>` 3-person
- Domains: strategy, architecture, decision, ethics, risk, shipping, ai

### 🌍 ATLAS — Project Intelligence
Run `atlas/init.sh` in your project.
7 modules: core, quality, metrics, docs, team, reports

### 🔧 CLI Tools
- `gograph` — Go AST analysis
- `serena` — MCP toolkit
- `opencli` — Website → CLI
- `bridle` — TUI config manager
- `claude-mem` — Persistent memory
- `prism` — Code style profiling
- `chamber` — Session management
- `echo` — Context mirroring
