---
name: planning-with-files
description: "Geliştirme aracı / güvenlik — Crash-proof planning (context kaybına dayanıklı) 24024⭐"
---

# Planning with Files

Crash-proof planning — dosya bazlı planlama ile context kaybına dayanıklı geliştirme.

## Ne İşe Yarar

- Planları dosyada tut, context kaybetme
- Adım adım ilerleme takibi
- Rollback noktaları
- Ekip koordinasyonu

## Yapı

```
PLAN.md          → Ana plan
tasks/           → Görev dosyaları
  task-001.md    → Her görev için ayrı dosya
  task-002.md
progress.md      → İlerleme günlüğü
```

## Kullanım

```bash
planning init            # Plan dosyası oluştur
planning task add "..."  # Görev ekle
planning status          # Durum göster
```
