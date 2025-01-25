
# Source bash aliases.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Enable starship prompt
command -v starship &>/dev/null && eval "$(starship init bash)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &>/dev/null && fzf --bash &>/dev/null && source <(fzf --bash)

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
