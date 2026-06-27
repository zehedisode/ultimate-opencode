---
name: claude-code-memory-mcp
description: "Entegrasyon / MCP — Claude Code kalıcı bellek MCP sunucusu 3K⭐"
---

# Claude Code Memory MCP

Claude Code için kalıcı bellek sağlayan MCP sunucusu.

## Ne İşe Yarar

- Oturumlar arası context koruma
- Proje hafızası (öğrenilenler, keşifler)
- Kullanıcı tercihleri ve geçmişi
- Cross-session knowledge persistence

## Kullanım

MCP üzerinden otomatik çalışır. Manuel kullanım:

```bash
npx @modelcontextprotocol/memory-server
```

## Bellek Türleri

- Kısa vadeli (oturum içi)
- Uzun vadeli (proje bazlı)
- Global (kullanıcı bazlı)
