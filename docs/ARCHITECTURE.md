# 🏗️ Architecture

## Overview

Ultimate OpenCode turns a fresh opencode install into FULL MOD in 5 minutes.

## Components

### 📁 agents/ — 103 Subagent Personas
10 categories of expert AI personas. Each has:
- `subagent_type` — for opencode invocation
- `model` — claude-3-opus or claude-3-sonnet
- `tools` — permitted tool set
- `color` — TUI display color
- `description` — expertise area

### 📁 skills/ — 83 Skill Files
Each has YAML frontmatter + Markdown content:
```yaml
---
name: skill-name
description: "Category / Description ⭐"
---
```

### 📁 scripts/ — 11 CLI Scripts
| Script | Function |
|---|---|
| chamber.sh | Session manager |
| echo.sh | Context mirroring |
| prism.sh | Code style profiling |
| sync-stars.sh | Star count updater |
| benchmark.sh | Performance test |
| validate-council.sh | Council validation |
| skill-wrap.sh | Skill wrapper |
| cron-setup.sh | CRON setup |
| opencode.sh | Master launcher |

### 📁 council/ — 18 AI Personas
From Aristotle to Karpathy — 18 historical figures.

### 📁 atlas/ — Project Intelligence System
7 modules: core, quality, metrics, docs, team, reports

## Data Flow

```
install.sh                          uninstall.sh
  ├── config/   → ~/.config/opencode/     ← removes
  ├── skills/   → ~/.config/opencode/skills/
  ├── agents/   → ~/.config/opencode/agents/
  ├── scripts/  → ~/.config/opencode/scripts/ + PATH
  ├── council/  → ~/.claude/agents/
  └── atlas/    → ~/.opencode/atlas/
```
