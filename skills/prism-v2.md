---
name: prism-v2
description: "🧠 PRISM 2.0 — Kişisel AI Evrim Sistemi. Kod stilini otomatik analiz eder, profiling yapar, sana özel asistan olur. PRISM v1'in 10x gelişmiş halidir."
---

# 🧠 PRISM 2.0 — Personal Reflective Intelligence & Style Mirror

PRISM 2.0, v1'in temel konseptini 10x ileri taşır: artık sadece seni öğrenmekle kalmaz, **aktif olarak kod stilini analiz eder, profiling çıkarır, ve çoklu oturumlarda stilini korur.**

## v1'den Farkı

| Özellik | PRISM v1 | PRISM 2.0 |
|---|---|---|
| Stil Öğrenme | Pasif (gözlemler) | **Aktif (analiz + profiling)** |
| Profil Çıkarma | Yok | **Kod stili fingerprint** |
| Cross-Session | Zayıf | **Güçlü (profil dosyası)** |
| Öneri | Yok | **"Bu kod stilinde şunu öneririm"** |
| Adaptasyon | Tek seans | **Sürekli (profil güncellenir)** |

## Nasıl Çalışır

```mermaid
flowchart LR
  A[Kod Yazıyorsun] --> B[PRISM 2.0 Analiz]
  B --> C{Stil Profili}
  C --> D[İsimlendirme: camelCase]
  C --> E[Format: 2-space]
  C --> F[Desen: early return]
  C --> G[Framework: React]
  G --> H[Sonraki öneri: "Bu kod için custom hook"]
```

## Kurulum

```bash
prism init              # Profil başlat
prism profile           # Mevcut profili göster
prism analyze src/      # Klasörü analiz et
prism suggest <dosya>   # Dosya için stil önerisi
```

## Profil Çıktısı

```json
{
  "version": "2.0",
  "user": "~/.opencode/prism/profile.json",
  "style": {
    "naming_convention": "camelCase",
    "indentation": 2,
    "semicolons": true,
    "prefer_arrow_functions": true,
    "early_return": true,
    "max_line_length": 100
  },
  "frameworks": ["React", "Express"],
  "languages": ["TypeScript", "Python"],
  "learned_patterns": [
    "Custom hook'ları use- ile adlandırır",
    "Error handling'de try/catch kullanır"
  ],
  "session_count": 42,
  "last_updated": "2026-06-28"
}
```

## AI Asistan Entegrasyonu

PRISM 2.0 profili, opencode AGENTS.md üzerinden tüm subagent'lar tarafından okunabilir. Böylece:
- Python agent'ı senin Python stilini bilir
- React agent'ı senin component desenlerini bilir
- Commit agent'ı commit mesajı stilini bilir

## Gizlilik

Tüm profil LOCAL'de kalır. Hiçbir şey dışarı gönderilmez.
