---
name: hol-guard
description: "Geliştirme aracı / güvenlik — AI antivirüs: zararlı komutları engeller 372⭐"
---

# Hol Guard

AI antivirüs — açık opencode için zararlı komut engelleme sistemi.

## Ne İşe Yarar

- Tehlikeli komutları algılar ve engeller
- Sistem dosyalarına erişimi kısıtlar
- API key leak'lerini önler
- Ransomware benzeri davranışları tespit eder

## Kullanım

```bash
hol-guard enable          # Korumayı aktifleştir
hol-guard disable         # Devre dışı bırak
hol-guard log             # Son olayları göster
hol-guard allow <cmd>     # Komuta izin ver
```

## Koruma Kapsamı

- `rm -rf /*` gibi yıkıcı komutlar
- API key/secret okuma
- Dosya şifreleme araçları
- Reverse shell komutları
