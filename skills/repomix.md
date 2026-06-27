---
name: repomix
description: "Geliştirme aracı / güvenlik — Tüm repoyu tek LLM-prompt dosyasına sıkıştır 5K⭐"
---

# Repomix

Tüm repository'yi tek bir LLM-prompt dosyasına sıkıştırır.

## Ne İşe Yarar

- Büyük projeleri LLM context'ine sığdır
- Kod tabanını tek dosyada topla
- Token-optimize edilmiş çıktı
- Dil bazlı akıllı filtreleme

## Kullanım

```bash
repomix                    # Tüm repoyu sıkıştır
repomix --style markdown   # Markdown çıktı
repomix --include "src/**"  # Sadece belirli dosyalar
repomix --token-count       # Token sayısını göster
```

## Özellikler

- 100+ dil desteği
- .gitignore bilinçli
- Token sayma ve optimizasyon
- Çıktı formatı: XML, Markdown, Plain
