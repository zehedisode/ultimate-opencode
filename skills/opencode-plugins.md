---
name: opencode-plugins
description: "Entegrasyon / MCP — opencode plugin geliştirme rehberi ve şablonları 1567⭐"
---

# Opencode Plugins

opencode plugin geliştirme rehberi, şablonlar ve örnekler.

## Ne İşe Yarar

- Plugin template oluştur
- Plugin yayınlama rehberi
- API referansı
- Örnek plugin'ler

## Hızlı Başlangıç

```bash
npx opencode-plugins init my-plugin
npx opencode-plugins build
npx opencode-plugins publish
```

## Template Yapısı

```
my-plugin/
├── index.js        # Plugin kodu
├── package.json    # Bağımlılıklar
├── README.md       # Dokümantasyon
└── test/           # Testler
```

## API

- `opencode.onCommand()`
- `opencode.onMessage()`
- `opencode.onSession()`
- `opencode.config()`
