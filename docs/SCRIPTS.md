# Script Referansı

## opencode.sh — Master Launcher

```bash
./scripts/opencode.sh <komut> [args]
```

Tüm script'leri tek yerden yönetir.

## chamber.sh — Session Manager

```bash
chamber new <ad>              # Yeni session
chamber list                  # Listele
chamber snapshot              # State kaydet
chamber parallel "a" "b"     # Paralel çalıştır
chamber --json                # JSON çıktı
```

## echo.sh — Context Mirroring

```bash
echo share "mesaj"            # Bilgi paylaş
echo broadcast "duyuru"       # Tüm session'lara duyur
echo status                   # Durum göster
echo history                  # Geçmiş
echo --json                   # JSON çıktı
```

## prism.sh — Kod Stili Profiling

```bash
prism init                    # Profil oluştur
prism profile                 # Profili göster
prism analyze src/            # Kod analizi
prism suggest file.ts         # Stil önerisi
prism --json                  # JSON çıktı
```

## sync-stars.sh — Star Güncelleme

```bash
./scripts/sync-stars.sh       # Tüm star'ları güncelle
```

Rate-limit korumalı, sleep ile.

## benchmark.sh — Performans Testi

```bash
./scripts/benchmark.sh        # Tam test
./scripts/benchmark.sh --quick  # Hızlı test
./scripts/benchmark.sh --json   # JSON çıktı
```

## validate-council.sh — Council Doğrulama

```bash
./scripts/validate-council.sh  # SKILL.md referanslarını doğrula
```

## cron-setup.sh — CRON Kurulumu

```bash
./scripts/cron-setup.sh       # Haftalık star sync CRON
```

## skill-wrap.sh — Skill Wrapper

```bash
skill list                    # Tüm skill'leri listele
skill search "python"         # Skill ara
skill info caveman            # Skill detayı
skill count                   # Skill sayısı
```
