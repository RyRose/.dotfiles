# Source custom bash aliases.
[[ -f ~/.config/.bash_aliases ]] && source ~/.config/.bash_aliases

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
