# 🚀 Ultimate OpenCode — Hızlı Başlangıç

## 1. Kurulum

```bash
git clone https://github.com/zehedisode/ultimate-opencode.git
cd ultimate-opencode
./install.sh
```

## 2. Kullanım

```bash
# TUI'yi aç
opencode

# Slash komutlar
/commit              # Commit mesajı yaz
/review              # Kod review
/council <soru>      # 18 AI persona topla

# Agent çağır
@python-expert "Bu fonksiyonu optimize et"
@security-auditor "Bu kodu güvenlik açısından kontrol et"

# Özgün araçlar
chamber new feature-x    # Yeni session
echo share "keşif"       # Context paylaş
prism analyze src/       # Kod stili analiz
```

## 3. ATLAS Başlatma

```bash
cd projen
atlas/init.sh
```

## 4. Önemli Komutlar

```bash
./verify.sh --self       # Repo bütünlüğü
./scripts/benchmark.sh   # Performans testi
./scripts/sync-stars.sh  # Star güncelleme
./uninstall.sh           # Kaldırma
```
