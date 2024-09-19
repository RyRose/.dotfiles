#!/usr/bin/env zsh

# Download antigen if unavailable and source.
[ ! -f ~/.config/antigen.zsh ] && curl -s -L git.io/antigen >~/.config/antigen.zsh
source ~/.config/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle bazel
antigen bundle command-not-found
antigen bundle sdk

# nvm is slow, lazily load on first use.
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript nvim vim
antigen bundle nvm

antigen apply

# Source bash aliases if exists.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Ignore history for commands doing file navigation in lieu of autocomplete.
# Filesystem suggestions are more relevant.
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="(cd|ls|ll) *"

# Default to history then autocomplete if not in the history.
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# Enable vi mode and accept suggestions with ctrl-y to match nvim.
# Must be in this order to work properly.
bindkey -v
bindkey '^y' autosuggest-accept

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
