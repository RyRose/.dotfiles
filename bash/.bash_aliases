#!/usr/bin/env bash

# Source ~/.env and ~/.zsh files.
set -eu
[ -s ~/.env ] && source ~/.env
if [[ -d ~/.bash ]]; then
  for file in ~/.bash/*.sh; do
    [ -s "${file}" ] && source "${file}"
  done
fi
set +eu

# Enable starship if it exists.
command -v starship &> /dev/null && eval "$(starship init bash)"

alias ..='cd ..'
alias sl='ls'
alias vim='nvim'
