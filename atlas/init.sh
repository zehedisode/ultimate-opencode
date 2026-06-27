#!/bin/bash
# 🌍 ATLAS — Proje Bilinç Sistemi Başlatma

echo "🌍 ATLAS Project Intelligence System"
echo "================================"
echo ""

# .opencode/atlas yoksa oluştur
mkdir -p .opencode/atlas
mkdir -p .opencode/atlas/core
mkdir -p .opencode/atlas/quality
mkdir -p .opencode/atlas/metrics
mkdir -p .opencode/atlas/team
mkdir -p .opencode/atlas/reports

# ATLAS dosyalarını kopyala
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$SCRIPT_DIR"

echo "📦 Modüller kuruluyor..."
cp -r "$SOURCE/core/"* .opencode/atlas/core/ 2>/dev/null || true
cp -r "$SOURCE/quality/"* .opencode/atlas/quality/ 2>/dev/null || true
cp -r "$SOURCE/metrics/"* .opencode/atlas/metrics/ 2>/dev/null || true
cp -r "$SOURCE/team/"* .opencode/atlas/team/ 2>/dev/null || true
cp -r "$SOURCE/reports/"* .opencode/atlas/reports/ 2>/dev/null || true

echo "✅ ATLAS hazır!"
echo ""
echo "📍 Konum: .opencode/atlas/"
echo "📋 Modüller:"
echo "  core/     — Proje bilinci + kararlar + değişiklikler"
echo "  quality/  — Standartlar + review + regresyon"
echo "  metrics/  — Maliyet + performans + ısı haritası"
echo "  team/     — Takım koordinasyonu"
echo "  reports/  — Haftalık rapor + içgörüler"
echo ""
echo "🚀 Kullanım:"
echo "  AI asistanın ATLAS'ı otomatik kullanır"
echo "  Detaylar: atlas/SKILL.md"
