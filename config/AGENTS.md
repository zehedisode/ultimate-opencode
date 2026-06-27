<!-- CODEGRAPH_START -->
## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
<!-- CODEGRAPH_END -->

<!-- codebase-memory-mcp:start -->
# Codebase Knowledge Graph (codebase-memory-mcp)

This project uses codebase-memory-mcp to maintain a knowledge graph of the codebase.
ALWAYS prefer MCP graph tools over grep/glob/file-search for code discovery.

## Priority Order
1. `search_graph` — find functions, classes, routes, variables by pattern
2. `trace_path` — trace who calls a function or what it calls (depth 1-5)
3. `get_code_snippet` — read specific function/class source code
4. `query_graph` — run Cypher queries for complex patterns (MATCH (f:Function)-[:CALLS]->(g) WHERE ...)
5. `get_architecture` — high-level project summary (languages, packages, routes, hotspots, clusters)
6. `detect_changes` — map git diff to affected symbols + blast radius with risk classification
7. `search_code` — grep-like text search within indexed project files
8. `manage_adr` — CRUD for Architecture Decision Records

## When to fall back to grep/glob
- Searching for string literals, error messages, config values
- Searching non-code files (Dockerfiles, shell scripts, configs)
- When MCP tools return insufficient results
- Use `search_code` tool for grep-like search within indexed files

## Examples
- Find a handler: `search_graph(name_pattern=".*OrderHandler.*")`
- Who calls it: `trace_path(function_name="OrderHandler", direction="inbound")`
- Read source: `get_code_snippet(qualified_name="pkg/orders.OrderHandler")`
- Dead code: `query_graph('MATCH (f:Function) WHERE NOT EXISTS { (f)<-[:CALLS]-() } RETURN f.name')`
- Impact: use `detect_changes` on current branch
<!-- codebase-memory-mcp:end -->

## gograph (CLI)

For Go projects, use `gograph` CLI for AST-based code analysis:
- `gograph build` - index the repo
- `gograph callers <func>` - find callers
- `gograph deps <pkg>` - dependency graph
- `gograph impact <func>` - impact analysis
Add `--json` for machine output, `--mermaid` for diagrams.

## Serena (MCP Toolkit)

For semantic code retrieval, refactoring and editing:
- `serena init` - initialize in a project
- `serena project add .` - add current project
- `serena context add` - query code context

## Web Search (Brave Search MCP)
Web araması için: `web_search(query="...")` veya `web_search(query="...", count=10)`
- Güncel bilgi, dokümantasyon, API referansları için kullan.

## Context7 MCP (Dokümantasyon)
Kütüphane/framework dökümantasyonu için: `context7_search(query="...")`
- npm paketleri, framework'ler, API'ler için hızlı doküman erişimi.

## Filesystem MCP
Dosya sistemi işlemleri için ek araçlar.

## OpenCLI (25.4K⭐)
Website'leri CLI komutlarına çevirir. Kullanım: `opencli <url> <komut>`

## SocratiCode (3K⭐)
Enterprise code intelligence. Hybrid semantic search, dependency graphs, impact analysis.

## cc-wf-studio (5.2K⭐)
Claude Code Workflow Studio - 16 skill + sub-agent workflows.
Skills: pr-review, jira-planning, workflow-tuning, pr-to-main.

## awesome-free-llm-apis (5.3K⭐)
Ücretsiz LLM API'leri listesi. Bedava model kullanmak için referans.

## AIClient2API (8.3K⭐)
Gemini, Antigravity, Codex, Grok, Kiro API'lerini OpenAI uyumlu hale getirir.

## Council of High Intelligence (1K⭐)
18 AI persona tek komutla: `/council <soru>`
Modlar: `--quick` (hızlı), `--duo` (ikili), `--triad <domain>` (3 kişi)
Domain'ler: strategy, architecture, decision, ethics, risk, shipping, ai

## ATLAS (Project Intelligence)
Projen için: `atlas/init.sh` ile başlat.
7 modül: core, quality, metrics, docs, team, reports
Her seansta proje bilincini otomatik günceller.
