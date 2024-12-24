
# Source bash aliases.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Enable starship prompt
command -v starship &>/dev/null && eval "$(starship init bash)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &>/dev/null && fzf --bash &>/dev/null && source <(fzf --bash)
. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"
