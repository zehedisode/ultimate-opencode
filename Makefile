.PHONY: install uninstall verify test benchmark clean docs

# Install Ultimate OpenCode
install:
	@echo "🚀 Installing Ultimate OpenCode..."
	@bash install.sh

# Uninstall
uninstall:
	@echo "🗑️ Uninstalling Ultimate OpenCode..."
	@bash uninstall.sh

# Verify integrity
verify:
	@echo "🔍 Verifying..."
	@bash verify.sh --self

# Run tests (requires bats)
test:
	@echo "🧪 Running tests..."
	@command -v bats >/dev/null 2>&1 || { echo "bats not found. Install: npm install -g bats"; exit 1; }
	@bats tests/test_basics.bats

# Benchmark
benchmark:
	@echo "📊 Benchmarking..."
	@bash scripts/benchmark.sh

# Sync star counts
stars:
	@echo "⭐ Syncing star counts..."
	@bash scripts/sync-stars.sh

# Setup cron
cron:
	@echo "⏰ Setting up cron..."
	@bash scripts/cron-setup.sh

# Show status
status:
	@echo "📊 Status:"
	@bash scripts/opencode.sh status

# Clean (dry-run uninstall)
clean:
	@echo "🧹 Clean mode..."
	@bash uninstall.sh --force

# Help
help:
	@echo "Available targets:"
	@echo "  install     Install Ultimate OpenCode"
	@echo "  uninstall   Remove Ultimate OpenCode"
	@echo "  verify      Verify repository integrity"
	@echo "  test        Run BATs test suite"
	@echo "  benchmark   Run performance benchmarks"
	@echo "  stars       Sync GitHub star counts"
	@echo "  cron        Setup weekly star sync"
	@echo "  status      Show project status"
	@echo "  clean       Dry-run uninstall"
