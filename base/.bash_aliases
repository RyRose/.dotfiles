# .bash_aliases to be sourced by both zsh and bash.

# Auto-install neovim dotfiles if not installed.
if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
	git clone -q https://github.com/RyRose/kickstart.nvim ~/.config/nvim
fi

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

# Source custom bash aliases.
[[ -f ~/.config/.bash_aliases ]] && source ~/.config/.bash_aliases

alias python=python3
alias reload_nixos='sudo nixos-rebuild switch'
