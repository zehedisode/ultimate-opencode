---
name: opencode-mcp-filesystem
description: "Entegrasyon / MCP — opencode için güvenli dosya sistemi MCP sunucusu 1K⭐"
---

# Opencode MCP Filesystem

opencode için güvenli dosya sistemi erişimi sağlayan MCP sunucusu.

## Ne İşe Yarar

- Güvenli dosya okuma/yazma
- Dizin gezinme
- File search
- Path restriction

## Kullanım

```bash
npx @opencode/filesystem-server --allowed /home/user/project
```

## Güvenlik

- Belirlenen dizin dışına çıkılamaz
- Tüm işlemler loglanır
- Write izni opsiyonel
