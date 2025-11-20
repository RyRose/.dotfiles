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

# Use neovim as man pager.
export MANPAGER='nvim +Man!'

# Add Homebrew to PATH for Apple Silicon Macs
export PATH="$PATH:/opt/homebrew/bin"
