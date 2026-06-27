---
name: context-compressor
description: "Geliştirme aracı / güvenlik — AI context penceresini optimize eden sıkıştırma aracı 3421⭐"
---

# Context Compressor

AI context penceresini optimize eden akıllı sıkıştırma aracı.

## Ne İşe Yarar

- Context'i %40-60 sıkıştır
- Önemli bilgiyi koru
- Token limit aşımını önle
- Proje yapısını koru

## Kullanım

```bash
compress project/          # Projeyi sıkıştır
compress file.ts           # Dosyayı sıkıştır
compress --ratio 50        # %50 sıkıştırma hedefi
compress --preserve "imports,types"  # Önemli kısımları koru
```

## Stratejiler

- Yorum/satır atlama
- Import birleştirme
- Type/interface özetleme
- Test dosyası filtreleme
- node_modules hariç tutma
