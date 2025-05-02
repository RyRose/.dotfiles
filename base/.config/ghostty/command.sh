#!/usr/bin/env bash

start_tmux() {
	if tmux list-clients -t main 2>/dev/null | grep -q "main"; then
		exec tmux new-session
	else
		exec tmux new-session -A -s main
	fi
}

if command -v tmux &>/dev/null; then
	start_tmux
fi

for chosen_shell in zsh bash; do
	if command -v "$chosen_shell" &>/dev/null; then
		exec "$chosen_shell" -c "$(declare -f start_tmux); start_tmux || exec $chosen_shell"
	fi
done

echo "No suitable shell or tmux found."
exit 1
