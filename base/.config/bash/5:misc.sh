# Enable starship prompt
command -v starship &>/dev/null && eval "$(starship init bash)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &>/dev/null && fzf --bash &>/dev/null && source <(fzf --bash)

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Use less instead of more.
export PAGER="less"

# Use en_US.UTF-8 as the default locale.
export LANG=en_US.UTF-8

# Disable beep in less binary.
export LESS="${LESS:-} -R -Q"

# Aliases.
alias ..='cd ..'
alias ll='ls -la'
alias ls='ls --color=auto'
alias python=python3
alias sl='ls'
alias vim='nvim'
