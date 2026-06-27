---
name: opencode-mcp-postgres
description: "Entegrasyon / MCP — opencode için PostgreSQL MCP sunucusu 1832⭐"
---

# Opencode MCP PostgreSQL

opencode için PostgreSQL veritabanı MCP sunucusu.

## Ne İşe Yarar

- SQL sorguları çalıştırma
- Schema keşfi
- Tablo listeleme
- Read-only mod

## Kullanım

```bash
npx @opencode/postgres-mcp-server --connection "postgresql://..."
```

## Güvenlik

- Read-only mod (varsayılan)
- Query timeout
- Schema restriction
- Connection pooling
