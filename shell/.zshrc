#!/usr/bin/env zsh

# Source antigen.
if [ -f ~/.config/antigen.zsh ]; then
    source ~/.config/antigen.zsh
    antigen use oh-my-zsh
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-completions
    antigen apply
fi

# Source bash aliases.
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# Accept suggestions with ctrl-y to match nvim.
bindkey '^y' autosuggest-accept

# Turn off all beeps
unsetopt BEEP

# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable starship prompt
command -v starship &> /dev/null && eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &> /dev/null && source <(fzf --zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
