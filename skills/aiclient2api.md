---
name: aiclient2api
description: "Entegrasyon / MCP — Gemini/Antigravity/Codex API'lerini OpenAI uyumlu yap 8K⭐"
---

# AIClient2API

Gemini, Antigravity, Codex, Grok, Kiro API'lerini OpenAI uyumlu hale getiren proxy.

## Ne İşe Yarar

- Farklı LLM API'lerini tek OpenAI uyumlu formatta kullan
- Bedava/modern modellere erişim
- Çoklu provider desteği

## Desteklenen API'ler

| API | Durum |
|---|---|
| Google Gemini | ✅ |
| Antigravity | ✅ |
| Anthropic Codex | ✅ |
| Grok (xAI) | ✅ |
| Kiro | ✅ |

## Kullanım

```python
from openai import OpenAI
client = OpenAI(base_url="http://localhost:8080/v1")
response = client.chat.completions.create(...)
```
