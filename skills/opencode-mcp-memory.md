---
name: opencode-mcp-memory
description: "Entegrasyon / MCP — opencode için kalıcı bellek MCP sunucusu 2841⭐"
---

# Opencode MCP Memory

opencode için kalıcı bellek sağlayan MCP sunucusu.

## Ne İşe Yarar

- Oturumlar arası context koruma
- Öğrenilen bilgileri saklama
- Kullanıcı tercihleri
- Cross-session knowledge

## Kullanım

MCP üzerinden otomatik çalışır.

```bash
npx @opencode/memory-server
```

## Bellek Türleri

- Session memory (geçici)
- Project memory (kalıcı)
- Global memory (kullanıcı bazlı)
