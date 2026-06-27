# 🏗️ Mimari

## Genel Bakış

Ultimate OpenCode, açık opencode'u 5 dakikada full mod'a çeviren paket.

## Bileşenler

### 📁 agents/ — 103 Subagent Persona
10 kategoride uzman AI personadır. Her biri:
- `subagent_type` — opencode çağrısı için
- `model` — claude-3-opus veya claude-3-sonnet
- `tools` — yetkili araçlar
- `color` — TUI rengi

### 📁 skills/ — 77 Skill Dosyası
Her biri YAML frontmatter + Markdown içerik:
```yaml
---
name: skill-adi
description: "Kategori / Açıklama ⭐"
---
```

### 📁 scripts/ — 11 CLI Script
| Script | İşlev |
|---|---|
| chamber.sh | Session yöneticisi |
| echo.sh | Context mirroring |
| prism.sh | Kod stili profiling |
| sync-stars.sh | Star güncelleme |
| benchmark.sh | Performans testi |
| validate-council.sh | Council doğrulama |
| skill-wrap.sh | Skill wrapper |
| cron-setup.sh | CRON kurulumu |

### 📁 council/ — 18 Yapay Zeka Persona
Aristoteles'ten Karpathy'e 18 tarihi figür.

### 📁 atlas/ — Proje Bilinç Sistemi
7 modül: core, quality, metrics, docs, team, reports

## Veri Akışı

```
install.sh
  ├── config/   → ~/.config/opencode/
  ├── skills/   → ~/.config/opencode/skills/
  ├── agents/   → ~/.config/opencode/agents/
  ├── scripts/  → ~/.config/opencode/scripts/ + PATH
  ├── council/  → ~/.claude/agents/
  └── atlas/    → ~/.opencode/atlas/
```
