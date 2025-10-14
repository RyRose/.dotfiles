# Auto-install neovim dotfiles if not installed.
if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
	git clone -q https://github.com/RyRose/kickstart.nvim ~/.config/nvim
fi

# Use neovim as the default editor.
export EDITOR=nvim
export VISUAL=nvim
