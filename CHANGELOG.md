# Changelog

## v1.1.0 (2026-06-28)
### 🔧 Loop #5: 10 Hata Düzeltmesi + Yeni Özellikler
- ✅ Skills klasöründen meta dosyaları temizlendi (CLA, CHANGELOG, CLAUDE, CODE_OF_CONDUCT, AGENTS → skills/)
- ✅ 6 adet "404: Not Found" skill dosyası gerçek içerikle dolduruldu (ask-user-questions, bridle, opencli, aiclient2api, openpets, agentify-desktop)
- ✅ install.sh: duplicate `set -euo pipefail` kaldırıldı, progress bar iyileştirildi
- ✅ install.sh: self_update artık python3 gerektirmiyor (pure bash/grep)
- ✅ README güncellendi: sayılar düzeltildi, skill tablosu genişletildi
- ✅ 7 yeni popüler skill eklendi: cursor-tools, claude-code-memory-mcp, repomix, screenshot-to-code, claude-code-sync, mcp-router, opencode-installer
- ✅ config/opencode.json: 8 plugin ile senkronize
- ✅ ATLAS: docs/api.md, docs/architecture.md, team/sync.md eklendi
- ✅ GitHub workflow geliştirildi: frontmatter doğrulama, 404 kontrolü, JSON/JSONC validasyon
- ✅ systemd servisi genişletildi, bash completion kapsamlı hale getirildi
- ✅ Dockerfile multi-arch desteği kazandı (linux/amd64, linux/arm64)
- ✅ verify.sh: `--self` (repo bütünlüğü) ve `--json` modları eklendi
- ✅ rollback.sh: liste görünümü iyileştirildi

## v1.0.0 (2026-06-27)
### 🚀 İlk Sürüm
- 4 MCP Server (codegraph, codebase-memory, context7, filesystem)
- 41 Skill (kategorize edilmiş, frontmatter'lı)
- 103 Agent Persona (10 kategori)
- 14 Slash Komut
- 7 Plugin
- 18 Council of High Intelligence agent
- 🌍 ATLAS Project Intelligence System (7 modül)
- Tek komut kurulum (install.sh)
- Rollback (rollback.sh)
- Doğrulama (verify.sh)
- OS Algılama (Linux/macOS/Arch/Debian/Fedora)
- Otomatik yedekleme
- Network timeout yönetimi
- SELinux/AppArmor uyarısı
- NPM/pnpm/yarn fallback
- Bash completion
- Dockerfile
- systemd service
- MIT License
- GitHub Pages website
- AI OpenAI
