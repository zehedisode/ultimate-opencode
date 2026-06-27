#!/bin/bash
# ⏰ Ultimate OpenCode CRON kurulumu
# Haftalık star güncelleme için CRON job ekler

set -euo pipefail
CRON_JOB="0 8 * * 1 cd $(cd "$(dirname "$0")/.." && pwd) && bash scripts/sync-stars.sh >> /tmp/ultimate-opencode-stars.log 2>&1"

# Mevcut CRON'u kontrol et
EXISTING=$(crontab -l 2>/dev/null || true)
if echo "$EXISTING" | grep -q "sync-stars.sh"; then
    echo "✅ CRON job zaten var"
    exit 0
fi

# Yeni CRON ekle
(crontab -l 2>/dev/null || true; echo "$CRON_JOB") | crontab -
echo "✅ CRON job eklendi: Her Pazartesi 08:00'de star sync çalışır"
echo "   Log: /tmp/ultimate-opencode-stars.log"
