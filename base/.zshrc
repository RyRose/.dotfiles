#!/usr/bin/env zsh

# Use vi mode for zsh. Must to be at top to make sure everything assumes vi mode.
bindkey -v

# Always load oh-my-zsh configuration.
source ~/.config/zsh/oh-my-zsh.zsh

# Source bash aliases if exists.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Turn off all beeps
unsetopt BEEP

# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable dotfiles to be globbed. This allows the use of tab to show hidden files.
setopt globdots

# Enable starship prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
command -v fzf &>/dev/null && fzf --zsh &>/dev/null && source <(fzf --zsh)

# Set up zoxide for directory navigation
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"

function set_precmd_win_title() {
	if [ -z "${TMUX}" ]; then
		return
	fi
	# Cancel any pending delayed title update
	if [[ -n "$title_delay_pid" ]]; then
		kill "$title_delay_pid" 2>/dev/null
		unset title_delay_pid
	fi
	local win_title="$(basename "$PWD")"
	echo -ne "\033]2;${win_title}\007"
}
precmd_functions+=(set_precmd_win_title)

function set_preexec_win_title() {
	if [ -z "${TMUX}" ]; then
		return
	fi

	local win_title
    [[ "$1" =~ "^[[:space:]]*([^[:space:]]+)" ]] && win_title=$match[1]

	# Kill any existing delayed title update
	if [[ -n "$title_delay_pid" ]]; then
		kill "$title_delay_pid" 2>/dev/null
		unset title_delay_pid
	fi
	# Schedule new title update to occur after 1 second
	(
		sleep 1
		echo -ne "\033]2;${win_title}\007"
	) 2>/dev/null &!
	title_delay_pid=$!
	typeset -g title_delay_pid
}
preexec_functions+=(set_preexec_win_title)

# Initialize opam if available
[ -f ~/.opam/opam-init/init.zsh ] && source ~/.opam/opam-init/init.zsh

# Initialize env if available.
[ -f ~/.local/bin/env ] && . ~/.local/bin/env

# Initialize home-manager session variables if available.
[ -f /etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh ] && source /etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# TODO: Consider exploring zellij again.
# command -v zellij &>/dev/null && ZELLIJ_AUTO_ATTACH=true ZELLIJ_AUTO_EXIT=true eval "$(zellij setup --generate-auto-start zsh)"
