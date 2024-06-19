#!/usr/bin/env fish

if status is-interactive

  # Source ~/.fishenv and ~/.fish files.
  [ -s ~/.fishenv ] && source ~/.fishenv
  for file in ~/.fish/*.fish
    source "$file"
  end

  command -v starship &>/dev/null && starship init fish | source

  alias ..='cd ..'
  alias ll='ls -la'
  alias ls='ls --color=auto'
  alias vim='nvim'
end

