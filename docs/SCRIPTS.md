# Script Reference

## opencode.sh — Master Launcher

```bash
./scripts/opencode.sh <command> [args]
```

Manage all scripts from one place.

## chamber.sh — Session Manager

```bash
chamber new <name>              # Create session
chamber list                    # List sessions
chamber snapshot                # Save state
chamber parallel "a" "b"       # Run parallel
chamber --json                  # JSON output
```

## echo.sh — Context Mirroring

```bash
echo share "message"            # Share info
echo broadcast "alert"          # Broadcast to all
echo status                     # Show context
echo history                    # View history
echo --json                     # JSON output
```

## prism.sh — Code Style Profiling

```bash
prism init                      # Create profile
prism profile                   # Show profile
prism analyze src/              # Analyze code
prism suggest file.ts           # Style suggestion
prism --json                    # JSON output
```

## sync-stars.sh — Star Sync

```bash
./scripts/sync-stars.sh         # Update all stars
```

Rate-limit protected with delays.

## benchmark.sh — Performance Test

```bash
./scripts/benchmark.sh          # Full test
./scripts/benchmark.sh --quick  # Quick test
./scripts/benchmark.sh --json   # JSON output
```

## validate-council.sh — Council Validation

```bash
./scripts/validate-council.sh   # Validate SKILL.md references
```

## cron-setup.sh — CRON Setup

```bash
./scripts/cron-setup.sh         # Weekly star sync CRON
```

## skill-wrap.sh — Skill Wrapper

```bash
skill list                      # List all skills
skill search "python"           # Search skills
skill info caveman              # Skill details
skill count                     # Count skills
```
