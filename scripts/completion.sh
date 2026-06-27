# 🚀 Ultimate OpenCode Bash Completion
# Kaynak: source scripts/completion.sh

_ultimate_opencode() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local opts="--help --version --os --backup --restore --list-skills --list-agents --verify"
    
    case "${COMP_WORDS[1]}" in
        install) opts="--yes --no-plugins --no-mcp --no-atlas --dry-run" ;;
        restore) opts="" ;;
        *) opts="install restore verify help" ;;
    esac
    
    COMPREPLY=($(compgen -W "$opts" -- "$cur"))
}

complete -F _ultimate_opencode ultimate-opencode
