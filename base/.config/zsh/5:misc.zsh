# Add .local binaries to PATH per XDG Base Directory Specification.
export PATH="$PATH:$HOME/.local/bin"

# Turn off all beeps
unsetopt BEEP

# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable dotfiles to be globbed. This allows the use of tab to show hidden files.
setopt globdots

# Enable starship prompt
# command -v starship &>/dev/null && eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &>/dev/null && fzf --zsh &>/dev/null && source <(fzf --zsh)

# Set up zoxide for directory navigation
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"

# Add Homebrew to PATH for Apple Silicon Macs
export PATH="$PATH:/opt/homebrew/bin"

# Add ghcup (Haskell toolchain manager) to PATH
export PATH="$PATH:$HOME/.ghcup/bin"

# Add cargo (Rust toolchain manager) to PATH
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Set SOPS Age key file location.
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"

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
