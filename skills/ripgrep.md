---
name: ripgrep
description: "Geliştirme aracı / güvenlik — En hızlı kod arama CLI aracı 51K⭐"
---

# ripgrep (rg)

En hızlı kod arama CLI aracı. Regex, recursive, git-aware.

## Ne İşe Yarar

- Klasörlerde hızlı metin arama
- Regex desteği
- .gitignore otomatik saygı
- Renkli çıktı

## Kullanım

```bash
rg "pattern" src/          # Klasörde ara
rg -i "pattern"            # Case insensitive
rg -l "pattern"            # Sadece dosya adları
rg "class Foo" --type ts   # Sadece TypeScript
```

## Neden Hızlı?

- Rust ile yazılmış
- SIMD optimizasyonu
- Paralel tarama
- Git-aware filtreleme
