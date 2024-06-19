#!/usr/bin/env bash

# Source ~/.bash files.
if [[ -d ~/.bash ]]; then
  for file in ~/.bash/*.sh; do
    [ -s "${file}" ] && source "${file}"
  done
fi

# Enable starship if it exists.
command -v starship &> /dev/null && eval "$(starship init bash)"

alias ..='cd ..'
alias sl='ls'
alias vim='nvim'
