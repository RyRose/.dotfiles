#!/usr/bin/env zsh

# Source bash aliases.
[[ -f ~/.bash_aliases ]] &&. ~/.bash_aliases

# Turn off all beeps
unsetopt BEEP

# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable starship prompt
command -v starship &> /dev/null && eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
