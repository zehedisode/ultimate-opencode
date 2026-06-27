# 🚀 Ultimate OpenCode

**Sıfırdan kurulu bir opencode'u 5 dakikada full mod'a çeviren paket.**

19 farklı GitHub reposundan toplanmış en iyi skiller, agent'lar, MCP server'lar ve plugin'ler.

## 📦 İçindekiler

| Kategori | Adet | Açıklama |
|---|---|---|
| 📡 MCP Server | 4 | codegraph, codebase-memory-mcp, context7, filesystem |
| 👤 Agent Persona | 103 | 10 kategoride uzman subagent |
| 👥 Council | 18 | 18 AI persona ile `/council` |
| 🎯 Skill | 40+ | Token tasarrufu, güvenlik, planning... |
| ⚡ Slash Komut | 14 | /commit, /review, /test, /documentation... |
| 🔌 Plugin | 7 | GitLab, Gemini, websearch, helicone... |
| 👮 Cost Guard | 1 | $50 limit, %80 uyarı |

## ⚡ Kurulum

```bash
git clone https://github.com/YOUR_USERNAME/ultimate-opencode.git
cd ultimate-opencode
./install.sh
```

## 🔑 Kullanım

```
opencode                       # TUI'yi başlat
/council <soru>                # 18 AI persona tartışsın
@python-expert <soru>          # Python uzmanına sor
/commit                        # commit mesajı yaz
/quick-review                  # hızlı kod review
Ctr+T                          # model variant değiştir
Tab                            # build/plan arası geç
```

## 📡 MCP Server'lar

| Server | Görev |
|---|---|
| **codegraph** | Kod sembol grafiği, çağrı yolu analizi |
| **codebase-memory-mcp** | Kod zekası, Cypher sorguları |
| **context7** | Dökümantasyon arama |
| **filesystem** | Gelişmiş dosya işlemleri |

## 👤 Agent Persona Kategorileri

```bash
@general-*          @core-*              @languages-*
@infrastructure-*   @quality-security-*  @data-ai-*
@dev-exp-*          @specialized-*       @business-*
@meta-*             @curiosity-*
```

## 👥 Council of High Intelligence

```bash
/council Bu startup'ı satın almalı mıyız?
/council --quick Mikroservis mi monolit mi?
/council --duo scaling yaklaşımımız nedir?
/council --triad strategy Rakibimizle nasıl rekabet edelim?
```

## 🎯 Skill'ler

- `caveman` — 65% token tasarrufu
- `ponytail` — kıdemli dev gibi düşün
- `superpowers` — agentic skills framework
- `karpathy-skills` — kod prensipleri
- `planning-with-files` — crash-proof planning
- `raptor-security` — pentest ajanı
- `deliberation` — multi-model fikir
- `Claude-BugHunter` — 71 bug bounty skill
- `datadog`, `jira`, `mermaid`, `document-code`...

## ⚡ Slash Komutlar

`/commit`, `/review`, `/test`, `/documentation`, `/memory-bank`, `/datadog`, `/speckit`, `/compose-email`, `/fix-renovate-mr`...

## 🔌 Plugin'ler

- `helicone-session` — API observability
- `gemini-auth` — Gemini model auth
- `gitlab-plugin` — GitLab MR/issue tools
- `poe-auth` — Poe OAuth giriş
- `websearch` — Web arama
- `subagent-statusline` — subagent durumu

## 🤝 Kaynak Repolar

- colbymchenry/codegraph (55K⭐)
- DeusData/codebase-memory-mcp (17K⭐)
- obra/superpowers (239K⭐)
- multica-ai/andrej-karpathy-skills (183K⭐)
- oraios/serena (25K⭐)
- 0xNyk/council-of-high-intelligence (1K⭐)
- JuliusBrussee/caveman (77K⭐)
- DietrichGebert/ponytail (61K⭐)
- jjmartres/ai-coding-agents (33⭐)
- ve daha fazlası...

## 📝 Notlar

- `codegraph` için projende `codegraph init` çalıştır
- `Brave Search` API key gerektirir: `BRAVE_API_KEY=<key> opencode`
- `context7` API keysiz çalışır
- Tüm dosyalar `~/.config/opencode/` altına kopyalanır
