# 🗺️ Ultimate OpenCode — Roadmap & Remaining Issues

> **Status:** v1.7.0 — 287 files, 83 skills, 103 agents, 11 scripts, 3 original inventions
> **Last audit:** 2026-06-28 (Loop #13)

---

## 🚨 Known Issues (Unresolved)

These were identified during the final audit and remain unfixed:

### P1 — Critical

| # | Issue | File | Impact |
|---|-------|------|--------|
| 1 | `sync-stars.sh` hits GitHub API rate limit without `GITHUB_TOKEN` | `scripts/sync-stars.sh` | Star sync never succeeds |
| 2 | BATs tests never actually ran — `bats tests/test_basics.bats` never executed | `tests/test_basics.bats` | Test suite untested |
| 3 | GitHub Actions CI status unknown — no green check verified | `.github/workflows/validate.yml` | CI may be failing |

### P2 — High

| # | Issue | File | Impact |
|---|-------|------|--------|
| 4 | Council `--members` parameter expects `council-` prefix but users type short names | `council/council/SKILL.md` | `--members socrates` fails to find `council-socrates.md` |
| 5 | 71 skill files have Turkish body content (inconsistent with English README) | `skills/*.md` | Unprofessional for English audience |
| 6 | `install.sh` PATH injection only works after re-login — not in current session | `install.sh` | Scripts unavailable immediately |
| 7 | Fish shell not supported in PATH setup | `install.sh` | Fish users get no PATH injection |

### P3 — Medium

| # | Issue | File | Impact |
|---|-------|------|--------|
| 8 | `uninstall.sh` doesn't clean `$PATH` from active shell sessions | `uninstall.sh` | PATH pollution after uninstall |
| 9 | `cron-setup.sh` has no `--remove` flag to delete the cron job | `scripts/cron-setup.sh` | Can't undo without crontab -e |
| 10 | `docs/` and `tests/` directories not copied by `install.sh` | `install.sh` | Only available in repo, not after install |

---

## 🧪 Test Status

```
bats tests/test_basics.bats  →  NOT YET RUN
scripts/benchmark.sh         →  NOT YET RUN
GitHub CI                    →  STATUS UNKNOWN
```

---

## 📈 Proposed Features (Post-v1.7)

- **Loop #14:** Fix all P1+P2 issues above
- **Loop #15:** Add `GITHUB_TOKEN` support to sync-stars.sh, run BATs, verify CI
- **Loop #16:** Translate all 71 skill bodies to English
- **Loop #17:** Add Fish shell support to install.sh
- **Loop #18:** Comprehensive end-to-end testing

---

## 📊 Stats Snapshot

```
Skills:    83  (71 Turkish body, 12 English body)
Agents:    103 (all 5-field verified)
Scripts:   11  (3 original, 8 utility)
MCP:       14+
Plugins:   8
Commands:  14
Council:   18
ATLAS:     7 modules
Docs:      4 (QUICKSTART, ARCHITECTURE, SCRIPTS, ROADMAP)
Tests:     1 (16 BATs — untested)
Themes:    4 (Catpuccin)
Config:    5 files
GitHub:    7 templates
Total:     287 files
```
