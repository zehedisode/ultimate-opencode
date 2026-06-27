# Architecture Decision Records

## ADR-001: Ultimate OpenCode Paket Yapısı
- **Tarih:** 2026-06-27
- **Durum:** Kabul
- **Karar:** Monolitik repo — tüm skill, agent, MCP, plugin'ler tek repoda
- **Alternatif:** Ayrı repolar + paket yöneticisi
- **Gerekçe:** Tek komut kurulum hedefi, bağımlılık yönetimi basitliği

## ADR-002: Skill Formatı
- **Tarih:** 2026-06-27
- **Durum:** Kabul
- **Karar:** Markdown + YAML frontmatter
- **Alternatif:** YAML/JSON salt, TOML
- **Gerekçe:** opencode'un native formatı, okunabilirlik

## ADR-003: ATLAS Yerleşimi
- **Tarih:** 2026-06-27
- **Durum:** Kabul
- **Karar:** `.opencode/atlas/` — proje içinde gizli dizin
- **Alternatif:** `docs/atlas/`, `~/.config/opencode/atlas/`
- **Gerekçe:** Versiyon kontrolü, taşınabilirlik, gizlilik
