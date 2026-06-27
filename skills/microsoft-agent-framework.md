---
name: microsoft-agent-framework
description: "AI framework / agent harness — Microsoft multi-agent orchestration framework 11753⭐"
---

# Microsoft Agent Framework

Microsoft'un multi-agent orchestration framework'ü. Python + .NET.

## Ne İşe Yarar

- Multi-agent orchestration
- Group chat patterns
- Termination strategies
- Python + .NET SDK

## Kullanım

```python
from agent_framework import Agent, GroupChat

agent1 = Agent("Araştırmacı", ...)
agent2 = Agent("Yazar", ...)
chat = GroupChat([agent1, agent2])
chat.run("Konuyu araştır ve yaz")
```
