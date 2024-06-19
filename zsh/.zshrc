#!/usr/bin/env zsh

# Source ~/.env and ~/.zsh files.
set -eu
[ -s ~/.env ] && source ~/.env
if [[ -d ~/.zsh ]]; then
  for file in ~/.zsh/*.sh; do
    [ -s "${file}" ] && source "${file}"
  done
fi
set +eu

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable starship prompt
command -v starship &> /dev/null && eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

alias ..='cd ..'
alias ll='ls -la'
alias ls='ls --color=auto'
alias sl='ls'
alias vim='nvim'
