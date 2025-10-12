export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM=${ZSH_CUSTOM:-${ZSH}/custom}

# Install Oh My Zsh if not already installed.
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# Install custom zsh plugins if not already installed.
custom_plugins=(
	zsh-autosuggestions
	zsh-completions
	zsh-history-substring-search
	zsh-syntax-highlighting
)
for plugin in "${custom_plugins[@]}"; do
	dir="${ZSH_CUSTOM}/plugins/${plugin}"
	repo="https://github.com/zsh-users/${plugin}"

	if [ ! -d "$dir" ]; then
		git clone "$repo" "$dir"
	fi
done

ZSH_THEME="robbyrussell"

plugins=(
	command-not-found
	sdk
	nvm
	tmux
	zsh-autosuggestions
	zsh-completions
	zsh-history-substring-search
	zsh-syntax-highlighting
)
if command -v direnv >/dev/null 2>&1; then
	plugins+=("direnv")
fi

# Autostart tmux if not already inside a tmux session.
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_DEFAULT_SESSION_NAME=main

# nvm is slow, lazily load on first use.
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript nvim vim

# Default to history then autocomplete if not in the history.
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# zsh-history-substring-search configuration
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=standout,underline
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=standout

# Disable all omz aliases.
zstyle ':omz:*' aliases no

# Must be at very bottom to ensure configuration is loaded first.
source "$ZSH"/oh-my-zsh.sh

# Enable vi mode (again for some reason) and
# accept suggestions with ctrl-y to match nvim.
# Must be in this order to work properly following sourcing omz.
bindkey -v
bindkey '^y' autosuggest-accept
