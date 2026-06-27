#!/bin/bash
# 🌍 ATLAS — Proje Bilinç Sistemi Başlatma (proje içinde çalıştır)

BASE="$(cd "$(dirname "$0")" && pwd)"
TARGET=".opencode/atlas"

echo "🌍 ATLAS Project Intelligence"
echo "============================="

# Mevcut proje kontrol
if [ ! -f "package.json" ] && [ ! -f "go.mod" ] && [ ! -f "Cargo.toml" ] && [ ! -f "pyproject.toml" ]; then
    echo "⚠️  Proje dosyası bulunamadı. Yine de devam edilsin mi? [E/h]"
    read -r ans
    [[ "$ans" =~ ^[Hh] ]] && exit 1
fi

mkdir -p "$TARGET/core" "$TARGET/quality" "$TARGET/metrics" "$TARGET/docs" "$TARGET/team" "$TARGET/reports"

echo "📦 Modüller kuruluyor..."
cp -r "$BASE/core/"* "$TARGET/core/" 2>/dev/null || true
cp -r "$BASE/quality/"* "$TARGET/quality/" 2>/dev/null || true
cp -r "$BASE/metrics/"* "$TARGET/metrics/" 2>/dev/null || true
if [ -d "$BASE/docs" ]; then
  cp -r "$BASE/docs/"* "$TARGET/docs/" 2>/dev/null || true
fi
cp -r "$BASE/team/"* "$TARGET/team/" 2>/dev/null || true
cp -r "$BASE/reports/"* "$TARGET/reports/" 2>/dev/null || true

echo "✅ ATLAS bu projede aktif!"
echo "   📍 $TARGET/"
echo "   📋 Modüller: core quality metrics docs team reports"
echo ""
echo "💡 AI asistanın ATLAS'ı otomatik kullanacak."
