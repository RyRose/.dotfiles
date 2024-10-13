#!/usr/bin/env zsh

# Use vi mode for zsh. Must to be at top to make sure everything assumes vi mode.
bindkey -v

# Download antigen if unavailable and source.
[ ! -f ~/.config/antigen.zsh ] && curl -s -L git.io/antigen >~/.config/antigen.zsh
source ~/.config/antigen.zsh
antigen use oh-my-zsh

antigen bundle bazel
antigen bundle command-not-found
antigen bundle sdk
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

# nvm is slow, lazily load on first use.
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript nvim vim
antigen bundle nvm

antigen apply

# Source bash aliases if exists.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Ignore history for commands doing file navigation in lieu of autocomplete.
# Filesystem suggestions are more relevant.
# export ZSH_AUTOSUGGEST_HISTORY_IGNORE="(cd|ls|ll) *"

# Default to history then autocomplete if not in the history.
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Enable vi mode and accept suggestions with ctrl-y to match nvim.
# Must be in this order to work properly.
bindkey '^y' autosuggest-accept

# zsh-history-substring-search configuration
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=standout,underline
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=standout

# Turn off all beeps
unsetopt BEEP

# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable dotfiles to be globbed. This allows the use of tab to show hidden files.
setopt globdots

# Enable starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &>/dev/null && fzf --zsh &>/dev/null && source <(fzf --zsh)
