# .bash_aliases to be sourced by both zsh and bash.

# Use less instead of more.
export PAGER="less"

# Use en_US.UTF-8 as the default locale.
export LANG=en_US.UTF-8

# Disable beep in less binary.
export LESS="${LESS:-} -R -Q"

# Use neovim as the default editor.
export EDITOR=nvim
export VISUAL=nvim

# Installed Go binaries.
export PATH="$PATH:$HOME/go/bin"

# Custom binaries under home directory.
export PATH="$PATH:$HOME/bin"

# Install Ruby Gems to ~/gems
export PATH="$PATH:$HOME/.gems/bin"
export GEM_HOME="$HOME/.gems"

# Add anaconda binaries to PATH.
export PATH="$PATH:$HOME/anaconda3/bin"

# Add CUDA config for ML work.
export CUDA_DIR="$HOME/anaconda3/nvvm"
export XLA_FLAGS="--xla_gpu_cuda_data_dir=$CUDA_DIR"

# Aliases.
alias ..='cd ..'
alias ll='ls -la'
alias ls='ls --color=auto'
alias sl='ls'
alias vim='nvim'
