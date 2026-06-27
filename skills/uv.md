---
name: uv
description: "Geliştirme aracı / güvenlik — Rust'la yazılmış ultra hızlı Python package manager 40K⭐"
---

# uv — Ultra Fast Python Package Manager

Rust ile yazılmış, pip'in 10-100x hızlısı Python package manager.

## Ne İşe Yarar

- pip/pip-tools'un yerine geçer
- 10-100x daha hızlı paket kurulumu
- Virtualenv yönetimi
- Lock file desteği

## Kullanım

```bash
uv pip install -r requirements.txt   # 10x hızlı
uv venv                              # Virtual env oluştur
uv tool install <paket>              # Araç kurulumu
uv sync                              # Lock'dan senkronize et
```
