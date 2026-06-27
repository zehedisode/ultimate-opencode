#!/bin/bash
# 🚀 Ultimate OpenCode Master Launcher
# Tüm komutları tek yerden yönet
# Kullanım: opencode.sh <komut> [args]

set -euo pipefail
BASE="$(cd "$(dirname "$0")/.." && pwd)"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

case "${1:-help}" in
    install|kur)
        echo -e "${CYAN}🚀 Ultimate OpenCode Kurulum${NC}"
        bash "$BASE/install.sh" "${@:2}"
        ;;
    uninstall|kaldir)
        bash "$BASE/uninstall.sh" "${@:2}"
        ;;
    verify|dogrula)
        bash "$BASE/verify.sh" "${@:2}"
        ;;
    chamber)
        bash "$BASE/scripts/chamber.sh" "${@:2}"
        ;;
    echo)
        bash "$BASE/scripts/echo.sh" "${@:2}"
        ;;
    prism)
        bash "$BASE/scripts/prism.sh" "${@:2}"
        ;;
    skill)
        bash "$BASE/scripts/skill-wrap.sh" "${@:2}"
        ;;
    benchmark)
        bash "$BASE/scripts/benchmark.sh" "${@:2}"
        ;;
    validate-council)
        bash "$BASE/scripts/validate-council.sh" "${@:2}"
        ;;
    sync-stars)
        bash "$BASE/scripts/sync-stars.sh" "${@:2}"
        ;;
    cron)
        bash "$BASE/scripts/cron-setup.sh" "${@:2}"
        ;;
    status|st)
        echo -e "${CYAN}📊 Ultimate OpenCode Status${NC}"
        echo -e "  Skills:    ${GREEN}$(ls "$BASE/skills"/*.md 2>/dev/null | wc -l)${NC}"
        echo -e "  Agents:    ${GREEN}$(find "$BASE/agents" -name '*.md' 2>/dev/null | wc -l)${NC}"
        echo -e "  Scripts:   ${GREEN}$(ls "$BASE/scripts"/*.sh 2>/dev/null | wc -l)${NC}"
        echo -e "  Commands:  ${GREEN}$(ls "$BASE/commands"/*.md 2>/dev/null | wc -l)${NC}"
        echo -e "  Council:   ${GREEN}$(ls "$BASE/council/agents"/*.md 2>/dev/null | wc -l)${NC}"
        echo -e "  Total:     ${GREEN}$(find "$BASE" -type f -not -path '*/.git/*' | wc -l) dosya${NC}"
        echo -e "  Version:   ${CYAN}$(grep '^VERSION=' "$BASE/install.sh" | cut -d'"' -f2)${NC}"
        ;;
    version|v)
        echo "Ultimate OpenCode $(grep '^VERSION=' "$BASE/install.sh" | cut -d'"' -f2)"
        ;;
    help|--help|-h)
        echo "🚀 Ultimate OpenCode Master Launcher"
        echo ""
        echo "Kullanım: opencode.sh <komut> [args]"
        echo ""
        echo "Komutlar:"
        echo "  install, kur       Paketi kur"
        echo "  uninstall, kaldir  Paketi kaldır"
        echo "  verify, dogrula    Doğrulama çalıştır"
        echo "  chamber            Session yöneticisi"
        echo "  echo               Context mirroring"
        echo "  prism              Kod stili profiling"
        echo "  skill              Skill wrapper"
        echo "  benchmark          Performans testi"
        echo "  validate-council   Council doğrulama"
        echo "  sync-stars         Star güncelleme"
        echo "  cron               CRON kurulumu"
        echo "  status, st         Sistem durumu"
        echo "  version, v         Versiyon göster"
        ;;
    *)
        echo -e "${RED}❌ Bilinmeyen komut: $1${NC}" >&2
        bash "$0" help
        exit 1
        ;;
esac
