#!/bin/bash

export XCURSOR_SIZE=16
export LESS="$LESS -R -Q"

# Default to using vim.
export EDITOR=vim
export VISUAL=vim

# Installed Go binaries.
export PATH="$PATH:~/go/bin"

# Custom binaries under home directory.
export PATH="$PATH:~/bin"

# Install Ruby Gems to ~/gems
export PATH="$PATH:/gems/bin"
export GEM_HOME="$HOME/gems"
