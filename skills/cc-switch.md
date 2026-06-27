---
name: cc-switch
description: "Geliştirme aracı / güvenlik — Cross-platform AI CLI yöneticisi 109842⭐"
---

# CC Switch

Cross-platform AI asistan CLI yöneticisi. Claude Code, Codex, OpenCode, Gemini CLI tek arayüzde.

## Ne İşe Yarar

- Tüm AI CLI'ları tek komutla yönet
- Model/provider arasında geçiş
- Ortak konfigürasyon
- Session yönetimi

## Kullanım

```bash
cc-switch list                    # Mevcut CLI'ları listele
cc-switch use opencode            # Opencode'a geç
cc-switch config set model opus   # Model değiştir
cc-switch session save            # Session kaydet
```

## Desteklenen CLI'lar

- Claude Code
- OpenAI Codex CLI
- OpenCode
- Gemini CLI
- Cursor CLI
