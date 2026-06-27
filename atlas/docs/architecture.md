# Proje Mimarisi

## C4 Modeli (Container)

```mermaid
C4Context
  Person(user, "Geliştirici", "opencode kullanan yazılımcı")
  System(ultimate, "Ultimate OpenCode", "opencode full mod paketi")

  Container_Boundary(c1, "install.sh") {
    Container(skills, "Skills", "Markdown", "46 skill dosyası")
    Container(agents, "Agents", "Markdown", "103 agent persona")
    Container(config, "Config", "JSON/JSONC", "Opencode yapılandırması")
    Container(mcp, "MCP Servers", "npm/go", "5 MCP sunucu")
    Container(atlas, "ATLAS", "Markdown/bash", "Proje bilinç sistemi")
  }

  Rel(user, ultimate, "Tek komut kurar")
  Rel(ultimate, skills, "Kullanır")
  Rel(ultimate, agents, "Kullanır")
  Rel(ultimate, mcp, "Çalıştırır")
  Rel(ultimate, atlas, "Başlatır")
```

## Veri Akışı

```mermaid
flowchart LR
  A[install.sh] --> B[Config]
  A --> C[Skills]
  A --> D[Agents]
  A --> E[MCP]
  A --> F[ATLAS]
  G[opencode] --> B
  G --> C
  G --> D
  G --> E
  G --> F
```

## Dizin Yapısı

```
ultimate-opencode/
├── agents/        → 103 subagent persona (10 kategori)
├── atlas/         → 7 modüllü proje bilinç sistemi
├── commands/      → 14 slash komut
├── config/        → opencode yapılandırması
├── council/       → 18 AI persona
├── scripts/       → completion, systemd, plugin helper
├── skills/        → 46 skill dosyası
└── themes/        → 4 Catpuccin teması
```
