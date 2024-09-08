#!/usr/bin/env zsh

# Source antigen.
if [ -f ~/.config/antigen.zsh ]; then
    source ~/.config/antigen.zsh
    antigen use oh-my-zsh
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-completions
    antigen bundle bazel
    antigen bundle command-not-found
    antigen apply
fi

# Source bash aliases.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Ignore history for commands referencing filesystem paths in lieu of autocomplete.
# Filesystem suggestions are more relevant.
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="(cd|ls|ll|vim) *"

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
command -v fzf &>/dev/null && source <(fzf --zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
