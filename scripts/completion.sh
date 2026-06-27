# 🚀 Ultimate OpenCode Bash Completion
# Kaynak: source scripts/completion.sh

_ultimate_opencode() {
    local cur prev words cword
    _init_completion || return

    local main_opts="--help --version --dry-run --os --no-plugins --no-mcp --no-atlas --no-backup"
    local subcmds="install verify rollback help"

    if [[ $cword -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$subcmds $main_opts" -- "$cur"))
        return
    fi

    case "${COMP_WORDS[1]}" in
        install)
            COMPREPLY=($(compgen -W "--yes --no-plugins --no-mcp --no-atlas --no-backup --dry-run --help" -- "$cur"))
            ;;
        verify)
            COMPREPLY=($(compgen -W "--self --help --json" -- "$cur"))
            ;;
        rollback)
            COMPREPLY=($(compgen -W "--list --help" -- "$cur"))
            ;;
        *)
            COMPREPLY=($(compgen -W "$main_opts" -- "$cur"))
            ;;
    esac
}

complete -F _ultimate_opencode ultimate-opencode
complete -F _ultimate_opencode install.sh

# Skill/Agent name completion for opencode
_opencode_agent_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local agents_dir="${OPCODE_AGENTS_DIR:-$HOME/.config/opencode/agents}"
    local skills_dir="${OPCODE_SKILLS_DIR:-$HOME/.config/opencode/skills}"

    case "$cur" in
        @*)
            local agent="${cur#@}"
            COMPREPLY=($(compgen -W "$(find "$agents_dir" -name '*.md' -exec basename {} .md \; 2>/dev/null)" -- "$agent"))
            ;;
        /*)
            local cmd="${cur#/}"
            COMPREPLY=($(compgen -W "$(ls "$skills_dir"/*.md 2>/dev/null | xargs -n1 basename | sed 's/\.md$//')" -- "$cmd"))
            ;;
    esac
}
complete -F _opencode_agent_complete opencode
