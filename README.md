<div align="center">
  <h1>🚀 Ultimate OpenCode</h1>
  <p><b>Sıfır opencode'u 5dk'da full mod'a çeviren paket.</b></p>
  <p>19 repo → 4 MCP · 103 agent · 40+ skill · 14 komut · 7 plugin · 18 council</p>

  <a href="https://github.com/zehedisode/ultimate-opencode"><img src="https://img.shields.io/github/stars/zehedisode/ultimate-opencode?style=social"></a>
  <img src="https://img.shields.io/badge/platform-linux%20%7C%20macOS%20%7C%20wsl-blue">
  <img src="https://img.shields.io/badge/license-MIT-green">
</div>

---

## ⚡ Tek Komut Kurulum

```bash
git clone https://github.com/zehedisode/ultimate-opencode.git
cd ultimate-opencode
./install.sh
```

Ardından: `opencode` 🎉

---

## 📦 İçindekiler

| Kategori | Adet | Açıklama |
|---|---|---|
| 📡 **MCP Server** | 4 | codegraph, codebase-memory-mcp, context7, filesystem |
| 👤 **Agent Persona** | 103 | 10 kategoride uzman subagent |
| 👥 **Council** | 18 | `/council` ile 18 AI persona tartışır |
| 🎯 **Skill** | 24+ | Token tasarrufu, güvenlik, planning... |
| ⚡ **Slash Komut** | 14 | /commit, /review, /test, /documentation |
| 🔌 **Plugin** | 7 | GitLab, Gemini, websearch, helicone... |
| 👮 **Cost Guard** | 1 | $50 limit, %80 uyarı |
| 🎨 **Tema** | 4 | Catppuccin çeşitleri |

---

## 🔑 Kullanım

| Ne | Nasıl |
|---|---|
| **TUI'yi başlat** | `opencode` |
| **Model variant değiştir** | `Ctrl+T` (high/max/low) |
| **Agent değiştir** | `Tab` (build/plan) |
| **Council topla** | `/council <soru>` |
| **Uzman çağır** | `@python-expert` veya `@security-reviewer` |
| **Commit yaz** | `/commit` |
| **Kod review** | `/review` |
| **Test yaz** | `/test` |
| **Dokümantasyon** | `/documentation` |
| **Memory bank** | `/memory-bank` |

---

## 📡 MCP Server'lar

| Server | ⭐ | Ne işe yarar |
|---|---|---|
| **codegraph** | 55K | Kod sembol grafiği, çağrı yolu analizi |
| **codebase-memory-mcp** | 17K | Kod zekası, Cypher sorguları, etki analizi |
| **context7** | — | npm/framework dökümantasyon arama |
| **filesystem** | — | Gelişmiş dosya sistemi işlemleri |

---

## 👤 103 Agent Persona (10 Kategori)

```
00-general/        → communication-coach, general-purpose
01-core/           → api-designer, backend, fullstack, graphql, microservices, websocket
02-languages/      → angular, golang, java, javascript, laravel, nextjs, php, python, rails, react, rust, spring, sql, typescript, vue
03-infrastructure/ → cloud, database, devops, k8s, network, security, sre, terraform...
04-quality/        → code-review, debug, pentest, performance, qa, test-automation...
05-data-ai/        → ai-engineer, data-scientist, ml-engineer, nlp, prompt-engineer...
06-dev-exp/        → build, cli, docs, git, mcp, mermaid, refactoring...
07-specialized/    → blockchain, fintech, payment, quant...
08-business/       → product, project, scrum, technical-writer, ux...
09-meta/           → agent-organizer, orchestrator, task-distributor...
10-curiosity/      → astro, research, search, trend-analysis...
```

Kullanım: `@agent-adı <ne yapmak istiyorsun>`

---

## 👥 Council of High Intelligence

18 AI persona (Aristotle, Feynman, Kahneman, Torvalds...) farklı LLM'lerde tartışır.

```bash
/council Bu startup'ı satın almalı mıyız?
/council --quick Mikroservis mi monolit mi?
/council --duo scaling yaklaşımımız nedir?
/council --triad strategy Rakibimizle nasıl rekabet edelim?
/council --members torvalds,ada Bu abstraction değer mi?
```

---

## 🎯 Skill'ler

| Skill | ⭐ | Ne işe yarar |
|---|---|---|
| **claude-mem** | 84K | Persistent context across sessions |
| **get-shit-done** | 64K | Meta-prompting + spec-driven dev |
| **oh-my-openagent** | 63K | Agent harness (omo/lazycodex) |
| **gstack** | 117K | 23 opinionated Claude Code tools |
| **claude-code-best-practice** | 61K | Best practices |
| **ruflo** | 61K | Multi-agent swarms |
| **caveman** | 77K | %65 token tasarrufu |
| **ponytail** | 61K | Kıdemli dev gibi düşün |
| **ECC** | 222K | Agent harness (skills, memory, security) |
| **graphify** | 72K | Klasörü knowledge graph'a çevir |
| **superpowers** | 239K | Agentic skills framework |
| **karpathy-skills** | 183K | Kod prensipleri |
| **planning-with-files** | 24K | Crash-proof planning |
| **ospec** | 555 | Spec-driven development workflow |
| **raptor-security** | 3.2K | Pentest ajanı |
| **deliberation** | 107 | Multi-model second opinion |
| **prompt-master** | 9.8K | Prompt mühendisliği |
| **Claude-BugHunter** | 2.7K | 71 bug bounty skill |
| **cc-wf-studio** | 5.2K | 16 workflow skill |
| **arc-kit** | 2K | Enterprise architecture governance |
| **OpenCLI** | 25K | Website → CLI |
| **SocratiCode** | 3K | Enterprise code intel |
| **memorix** | 519 | Cross-agent memory |
| **opencode-swarm** | 369 | Swarm orchestrator |
| **bridle** | 431 | TUI config manager |
| **agentify-desktop** | 452 | Browser session control |
| **hol-guard** | 372 | AI antivirüs |
| **AIClient2API** | 8.3K | Free model gateway |
| **free-llm-apis** | 5.3K | Ücretsiz API listesi |

---

## ⚡ 14 Slash Komut

```
/commit          /review          /test            /documentation
/memory-bank     /datadog         /speckit         /compose-email
/fix-renovate-mr /commit-and-create-mr /next-sprint-design
/prepare-dataset /astro-dso-doc   /speckit.model-selector
```

---

## 🔌 7 Plugin

| Plugin | Ne işe yarar |
|---|---|
| **helicone-session** | API çağrılarını logla |
| **gemini-auth** | Google Gemini auth |
| **gitlab-plugin** | GitLab MR/issue yönetimi |
| **poe-auth** | Poe OAuth giriş |
| **websearch** | Web arama |
| **subagent-statusline** | Subagent durumu |

---

## 🔧 CLI Araçlar

| Araç | Açıklama |
|---|---|
| **serena** | MCP toolkit (`serena init` ile projene ekle) |
| **gograph** | Go AST analiz (`gograph callers <func>`) |
| **opencli** | Website'leri CLI yap (`opencli <url> <komut>`) |
| **codegraph** | Kod grafiği (`codegraph init` + `codegraph explore`) |

---

## 📝 Notlar

- `codegraph` için projende `codegraph init` çalıştır (tek sefer)
- `serena` için `serena init` çalıştır
- `context7` API keysiz çalışır
- Brave Search API key ister: `BRAVE_API_KEY=<key> opencode`
- `cost-guard` $50 limit koyar, %80'de uyarır

## 📜 Lisans

MIT
