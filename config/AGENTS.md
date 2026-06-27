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

> 💡 Tüm 103 agent artık `subagent_type` alanı içerir. Council agent'ları `claude-3-opus`/`claude-3-sonnet` modellerini kullanır.
>
> 🆕 **PRISM 2.0** — kod stili profiling. **CHAMBER** — multi-session yöneticisi. **ECHO** — cross-session context mirroring.

## 🛠️ Bu Projede Kullanılan Tüm Araçlar

### 📡 MCP Server'lar
| Araç | Ne İşe Yarar |
|---|---|
| **codegraph_explore** | Kod bilgi grafiği — tek sorguda kaynak + çağrı yolları |
| **search_graph / trace_path** | Semantik kod arama ve çağrı zinciri |

### 🎯 Skill'ler (Kategorik)

**⚡ Token & Performans**: caveman (%65 token tasarrufu), ponytail (kıdemli dev gibi düşün)

**🧠 AI Çerçeveleri**: ECC (222K⭐), superpowers (239K⭐), claude-mem (84K⭐), oh-my-openagent (63K⭐), ruflo (61K⭐), get-shit-done (64K⭐), graphify (72K⭐)

**📐 Kod Kalitesi**: karpathy-skills (183K⭐), claude-code-best-practice (61K⭐), gstack (117K⭐), arc-kit (2K⭐)

**🛡️ Güvenlik**: Claude-BugHunter (2.7K⭐), raptor-security (3.2K⭐), hol-guard (372⭐)

**🔧 Geliştirme**: planning-with-files (24K⭐), ospec (555⭐), OpenCLI (25K⭐), SocratiCode (3K⭐), prompt-master (9.8K⭐), deliberation (107⭐), memorix (519⭐), cc-wf-studio (5.2K⭐), opencode-swarm (369⭐), bridle (431⭐)

**🎨 Tasarım/Doküman**: serena (25K⭐), vercel-skills (23K⭐), openpets (838⭐), agentify-desktop (452⭐)

**🔌 Entegrasyon**: AIClient2API (8.3K⭐), codebase-memory-skill, firecrawl-mcp (6.7K⭐)

**📚 Referans**: awesome-free-llm-apis (5.3K⭐), ask-user-questions, ultimate-opencode

**🆕 Yeni Eklenenler (Loop #5)**: cursor-tools (8.6K⭐), claude-code-memory-mcp (3.2K⭐), repomix (5.1K⭐), screenshot-to-code (64K⭐), claude-code-sync (1.2K⭐), mcp-router (890⭐), opencode-installer (450⭐)

**🆕 Loop #6**: PRISM 2.0 (özgün), CHAMBER (özgün), ECHO (özgün), dify (147K⭐), n8n (194K⭐), chrome-devtools-mcp (44K⭐), uv (40K⭐), ripgrep (51K⭐), lazygit (55K⭐), antigravity-awesome-skills (41K⭐), awesome-mcp-servers (89K⭐)

**🆕 Loop #7**: pydantic-ai (18K⭐), microsoft-agent-framework (11K⭐), deepseek-reasonix (25K⭐), cc-switch (109K⭐), wshobson-agents (37K⭐), agent-reach (43K⭐)

**🆕 Loop #8**: agentic-threat-detection (4.8K⭐), opencode-mcp-hub (2.1K⭐), opencode-cost-optimizer (976⭐), context-compressor (3.4K⭐), swe-agent (12K⭐)

**🆕 Loop #9**: copilot-cli (4.3K⭐), aider (25K⭐), codex-cli (17K⭐), open-interpreter (55K⭐), continue (21K⭐), claude-code-cli (15K⭐)

### 🆕 Özgün Araç Script'leri (scripts/)
| Script | Açıklama |
|---|---|
| `chamber.sh` | Session yöneticisi — `chamber new/list/snapshot/parallel` |
| `echo.sh` | Context mirroring — `echo share/broadcast/status` |
| `prism.sh` | Kod stili profiling — `prism init/analyze/suggest` |
| `sync-stars.sh` | Skill star sayılarını GitHub API'den güncelle |

### 👥 Council of High Intelligence
`/council <soru>` — 18 AI persona ile multi-perspektif müzakere.
Detaylı kullanım için: `council/council/SKILL.md`
- `--quick` hızlı, `--duo` ikili, `--triad <domain>` 3 kişi
- Domain: strategy, architecture, decision, ethics, risk, shipping, ai

### 🌍 ATLAS — Project Intelligence
Projende `atlas/init.sh` çalıştır.
7 modül: core, quality, metrics, docs, team, reports

### 🔧 CLI Araçlar
- `gograph` — Go AST analiz
- `serena` — MCP toolkit
- `opencli` — Website → CLI
- `bridle` — TUI config manager
- `claude-mem` — Persistent memory
