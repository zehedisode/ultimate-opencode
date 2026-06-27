---
name: codebase-memory-skill
description: "Entegrasyon / MCP — Kod zekası knowledge graph 17397⭐"
---

# Codebase Memory Skill

Codebase Memory MCP'nin skill sürümü — kod zekası ve knowledge graph.

## Ne İşe Yarar

- Kod tabanını grafik olarak indeksle
- Cypher sorguları ile kod analizi
- Etki analizi
- Ölü kod tespiti
- Çapraz proje bağıntıları

## MCP Araçları

| Araç | Kullanım |
|---|---|
| `search_graph` | Fonksiyon/sınıf/route bul |
| `trace_path` | Çağrı zincirini takip et |
| `get_code_snippet` | Kaynak kodu oku |
| `query_graph` | Cypher sorgusu çalıştır |
| `get_architecture` | Mimari genel bakış |
| `detect_changes` | Değişiklik etki analizi |

## Kullanım

```bash
codebase-memory-mcp index   # Projeyi indeksle
codebase-memory-mcp search  # Kod ara
```
