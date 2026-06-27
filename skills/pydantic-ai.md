---
name: pydantic-ai
description: "AI framework / agent harness — Pydantic resmi AI Agent Framework (type-safe, Python) 18K⭐"
---

# Pydantic AI

Pydantic ekibinin resmi AI Agent Framework'ü. Type-safe agent geliştirme.

## Ne İşe Yarar

- Type-safe AI agent ajanları
- Structured output garantisi
- MCP uyumlu
- Python native

## Kullanım

```python
from pydantic_ai import Agent

agent = Agent(
    'claude-3-opus',
    system_prompt='Sen bir yardım asistanısın.',
)

result = agent.run_sync('Merhaba!')
print(result.data)
```

## Özellikler

- Type-safe responses
- Function calling
- Streaming
- MCP tools
