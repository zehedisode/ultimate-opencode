#!/bin/bash
# ⏪ Ultimate OpenCode - Geri Alma

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo "=========================================="
echo "  ⏪ Ultimate OpenCode - Geri Alma"
echo "=========================================="
echo ""

# Mevcut yedekleri bul
BACKUPS=($(ls -d ~/.config/opencode.yedek_* 2>/dev/null))
COUNT=${#BACKUPS[@]}

if [ "$COUNT" -eq 0 ]; then
    echo -e "${RED}❌ Hiç yedek bulunamadı!${NC}"
    exit 1
fi

echo "Mevcut yedekler:"
for i in "${!BACKUPS[@]}"; do
    echo "  [$((i+1))] ${BACKUPS[$i]}"
done
echo ""
echo -n "Geri almak istediğiniz yedek numarası [1-$COUNT]: "
read -r CHOICE

if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le "$COUNT" ]; then
    SELECTED="${BACKUPS[$((CHOICE-1))]}"
    echo ""
    echo -e "${YELLOW}⏪ Geri alınıyor: $SELECTED${NC}"
    rm -rf ~/.config/opencode
    cp -r "$SELECTED" ~/.config/opencode
    echo -e "${GREEN}✅ Geri alındı!${NC}"
    echo "   Eski konfigürasyonuna dönüldü."
else
    echo -e "${RED}❌ Geçersiz seçim${NC}"
    exit 1
fi
