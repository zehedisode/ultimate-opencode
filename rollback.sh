#!/bin/bash
# ⏪ Ultimate OpenCode - Rollback
# Restore from backup

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

echo "=========================================="
echo "  ⏪ Ultimate OpenCode - Rollback"
echo "=========================================="
echo ""

BACKUPS=($(ls -d ~/.config/opencode.backup_* 2>/dev/null))
COUNT=${#BACKUPS[@]}

if [ "$COUNT" -eq 0 ]; then
    echo -e "${RED}❌ No backups found!${NC}"
    exit 1
fi

echo "Available backups:"
for i in "${!BACKUPS[@]}"; do
    SIZE=$(du -sh "${BACKUPS[$i]}" 2>/dev/null | cut -f1)
    echo "  [$((i+1))] ${BACKUPS[$i]} (${SIZE})"
done
echo ""
echo -n "Select backup to restore [1-$COUNT]: "
read -r CHOICE

if [[ "$CHOICE" =~ ^[0-9]+$ ]] && [ "$CHOICE" -ge 1 ] && [ "$CHOICE" -le "$COUNT" ]; then
    SELECTED="${BACKUPS[$((CHOICE-1))]}"
    echo ""
    echo -e "${YELLOW}⏪ Restoring: $SELECTED${NC}"
    rm -rf ~/.config/opencode
    cp -r "$SELECTED" ~/.config/opencode
    echo -e "${GREEN}✅ Restored!${NC}"
    echo "   Previous configuration has been restored."
    echo "   Run 'opencode' to verify."
else
    echo -e "${RED}❌ Invalid selection${NC}"
    exit 1
fi
