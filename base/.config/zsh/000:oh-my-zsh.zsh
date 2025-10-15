export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM=${ZSH_CUSTOM:-${ZSH}/custom}

# Install Oh My Zsh if not already installed.
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# Install custom zsh plugins if not already installed and update if older than 24 hours.
custom_plugins=(
	"fzf-tab https://github.com/Aloxaf/fzf-tab"
	"zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions"
	"zsh-completions https://github.com/zsh-users/zsh-completions"
	"zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search"
	"zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting"
	"zsh-vi-mode https://github.com/jeffreytse/zsh-vi-mode"
)
update_interval=$((24 * 60 * 60)) # 24 hours
for entry in "${custom_plugins[@]}"; do
	read -r plugin repo <<<"$entry"
	dir="${ZSH_CUSTOM}/plugins/${plugin}"
	timestamp_file="${dir}/.last_update"

	if [ ! -d "$dir" ]; then
		echo "Cloning $plugin..."
		git clone "$repo" "$dir"
		date +%s >"$timestamp_file"
	else
		now=$(date +%s)
		last_update=0
		[ -f "$timestamp_file" ] && last_update=$(<"$timestamp_file")
		elapsed=$((now - last_update))

		if [ "$elapsed" -ge "$update_interval" ]; then
			echo "Updating $plugin..."
			(
				cd "$dir" && git pull --ff-only
			)
			date +%s >"$timestamp_file"
		fi
	fi
done

ZSH_THEME="robbyrussell"

plugins=(
	command-not-found
	zsh-autosuggestions
	zsh-completions
	zsh-history-substring-search
	zsh-syntax-highlighting
	zsh-vi-mode
)
if command -v direnv >/dev/null 2>&1; then
	plugins+=(direnv)
fi
if command -v fzf >/dev/null 2>&1; then
	plugins+=(fzf-tab)
fi
if command -v nvm >/dev/null 2>&1; then
	plugins+=(nvm)
fi
if command -v sdk >/dev/null 2>&1; then
	plugins+=(sdk)
fi
if command -v tmux >/dev/null 2>&1; then
	plugins+=(screen tmux)
fi

# Autostart tmux if not already inside a tmux session.
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_DEFAULT_SESSION_NAME=main

# Init ZVM on sourcing instead of lazily to allow keybinds to work.
export ZVM_INIT_MODE=sourcing

# nvm is slow, lazily load on first use.
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript nvim vim

# Default to history then autocomplete if not in the history.
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# zsh-history-substring-search configuration
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=standout,underline
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=standout

# Disable all omz aliases.
zstyle ':omz:*' aliases no

# Must be at very bottom to ensure configuration is loaded first.
source "$ZSH"/oh-my-zsh.sh

# Must follow sourcing oh-my-zsh.sh to ensure it overrides keybinds set by omz.
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey '^y' autosuggest-accept
