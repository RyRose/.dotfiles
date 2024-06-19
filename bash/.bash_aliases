#!/usr/bin/env bash

# Source .bash/ files.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
for file in "${SCRIPT_DIR}/.bash/"*.sh; do
  [ -s "${file}" ] && source "${file}"
done

# Enable starship if it exists.
command -v starship &> /dev/null && eval "$(starship init bash)"

alias ..='cd ..'
alias sl='ls'
alias vim='nvim'
