---
name: bridle
description: "Geliştirme aracı / güvenlik — TUI config manager 431⭐"
---

# Bridle — TUI Config Manager

Terminal kullanıcı arayüzü (TUI) ile opencode konfigürasyon yönetimi.

## Ne İşe Yarar

- opencode.jsonc şema doğrulama
- Görsel model/variant seçici
- MCP server toggle arayüzü
- Skill enable/disable yönetimi
- Renkli TUI çıktısı

## Kullanım

```bash
bridle                    # TUI'yi başlat
bridle --validate         # Config doğrula
bridle --schema           # Şema göster
bridle --help             # Yardım
```

## Entegrasyon

`config/opencode.jsonc` ile birlikte çalışır. Değişiklikler otomatik kaydedilir.
