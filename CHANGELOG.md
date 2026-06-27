# Changelog

## v1.2.0 (2026-06-28)
### 🔧 Loop #6: 11 Düzeltme + 3 Özgün Özellik + 8 Yeni Skill
- ✅ 103 agent dosyasına `subagent_type` alanı eklendi (opencode uyumluluğu)
- ✅ 18 council agent model adı `claude-3-opus`/`claude-3-sonnet` olarak güncellendi
- ✅ Council SKILL.md model tablosu güncellendi
- ✅ **🧠 PRISM 2.0** özgün özellik: kod stili profiling + fingerprint sistemi
- ✅ **⚡ CHAMBER** özgün özellik: multi-session orchestrator & state manager
- ✅ **🔊 ECHO** özgün özellik: cross-session context mirroring
- ✅ 8 yeni popüler GitHub skill: dify (147K⭐), n8n (194K⭐), chrome-devtools-mcp (44K⭐), uv (40K⭐), ripgrep (51K⭐), lazygit (55K⭐), antigravity-awesome-skills (41K⭐), awesome-mcp-servers (89K⭐)
- ✅ README'ye özgün özellikler bölümü eklendi + council SKILL.md referansı
- ✅ MCP tablosuna chrome-devtools eklendi, 5+ → 6+ MCP olarak güncellendi
- ✅ install.sh'ye curl_progress fonksiyonu eklendi, yeni MCP server tanımlandı
- ✅ atlas/init.sh docs/ ve team/sync modülü kurulumu dahil edildi
- ✅ AGENTS.md: yeni skill kategorileri, subagent_type ve council model duyurusu
- ✅ Toplam: 54 skill, 103 agent (tümü subagent_type'lı), 14 komut, 8 plugin, 18 council, 6+ MCP, 231 dosya

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
