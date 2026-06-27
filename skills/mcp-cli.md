---
name: mcp-cli
description: "Entegrasyon / MCP — MCP CLI: MCP sunucularını terminalden yönet 4732⭐"
---

# MCP CLI

MCP sunucularını terminalden yönetmek için CLI aracı.

## Ne İşe Yarar

- MCP sunucularını başlat/durdur
- Health check
- Config yönetimi
- Log takibi

## Kullanım

```bash
mcp-cli start postgres-mcp
mcp-cli status
mcp-cli logs codegraph
mcp-cli config set filesystem.path /home
```

## Özellikler

- Tüm MCP'leri tek yerden yönet
- Otomatik yeniden başlatma
- Resource monitoring
- Config export/import
