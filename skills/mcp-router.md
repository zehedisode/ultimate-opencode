---
name: mcp-router
description: "Entegrasyon / MCP — Çoklu MCP server yönlendirici 890⭐"
---

# MCP Router

Birden çok MCP sunucusu arasında akıllı yönlendirme yapan araç.

## Ne İşe Yarar

- MCP isteklerini doğru sunucuya yönlendir
- Load balancing
- Failover desteği
- Merkezi MCP yönetimi

## Kullanım

```bash
mcp-router start              # Router'ı başlat
mcp-router add server:port    # Sunucu ekle
mcp-router status              # Durum göster
```

## Özellikler

- Otomatik keşif
- Health check
- Round-robin load balancing
- Graceful degradation
