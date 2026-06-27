# Katkıda Bulunma

Ultimate OpenCode'a katkıda bulunduğun için teşekkürler! 🚀

## Ortam Kurulumu

```bash
git clone https://github.com/zehedisode/ultimate-opencode.git
cd ultimate-opencode
# Geliştirme için hiçbir şey kurmana gerek yok
# verify.sh --self ile bütünlüğü kontrol edebilirsin
```

## Yeni Skill Ekleme

1. `skills/` klasörüne `.md` dosyası ekle
2. YAML frontmatter ekle (zorunlu):
   ```yaml
   ---
   name: skill-adi
   description: "Kategori / Açıklama — ⭐"
   ---
   ```
3. `README.md`'deki skill tablosuna ekle
4. `AGENTS.md`'deki skill listesine ekle (eğer varsa)
5. `verify.sh`'e kontrol satırı ekle (opsiyonel)
6. `install.sh` otomatik kopyalar (skills/ altındaki tüm .md dosyaları)

## Yeni Agent Ekleme

1. `agents/XX-kategori/` altına `.md` ekle
2. YAML frontmatter ekle:
   ```yaml
   ---
   name: agent-adi
   description: "Kısa açıklama"
   ---
   ```
3. README'deki agent sayısını güncelle

## Yeni MCP Server Ekleme

1. `install.sh`'e `install_mcp` çağrısı ekle
2. `config/opencode.jsonc`'ye MCP tanımı ekle
3. README'deki MCP tablosuna ekle

## Kod Standartları

- Shell script'lerde: `set -euo pipefail` kullan
- Frontmatter tüm .md dosyalarında zorunlu
- "404: Not Found" içeriği asla olmamalı
- README sayıları gerçek dosya sayılarıyla eşleşmeli

## Doğrulama

```bash
./verify.sh --self    # Repo bütünlüğü kontrolü
bash -n install.sh    # Bash syntax kontrolü
```

## PR Süreci

1. Açıklayıcı bir branch adı: `fix/sorun-adi` veya `feature/yeni-ozellik`
2. Commit: `🔧 loop #N: yapılan değişiklikler`
3. PR aç ve `--self` doğrulamasının geçtiğinden emin ol
