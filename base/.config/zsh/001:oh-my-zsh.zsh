export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM=${ZSH_CUSTOM:-${ZSH}/custom}

# Install Oh My Zsh if not already installed.
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# Install custom zsh repos if not already installed.
custom_repos=(
	"plugins/fzf-tab                      https://github.com/Aloxaf/fzf-tab"
	"plugins/nix-shell                    https://github.com/chisui/zsh-nix-shell.git"
	"plugins/nix-zsh-completions          https://github.com/nix-community/nix-zsh-completions.git"
	"plugins/zsh-autosuggestions          https://github.com/zsh-users/zsh-autosuggestions"
	"plugins/zsh-completions              https://github.com/zsh-users/zsh-completions"
	"plugins/zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search"
	"plugins/zsh-syntax-highlighting      https://github.com/zsh-users/zsh-syntax-highlighting"
	"plugins/zsh-vi-mode                  https://github.com/jeffreytse/zsh-vi-mode"
	"themes/powerlevel10k                 https://github.com/romkatv/powerlevel10k.git"
)
for entry in "${custom_repos[@]}"; do
	read -r directory repo <<<"$entry"
	dir="${ZSH_CUSTOM}/${directory}"
	if [ ! -d "$dir" ]; then
		git clone "$repo" "$dir" &>/dev/null
	fi
done

# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	command-not-found
	nix-shell
	nix-zsh-completions
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
