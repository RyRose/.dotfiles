#!/usr/bin/env bash

if command -v tmux &>/dev/null; then
	if tmux list-clients -t main 2>/dev/null | grep -q "main"; then
		tmux new-session
	else
		tmux new-session -A -s main
	fi
elif command -v zsh &>/dev/null; then
	exec zsh
elif command -v bash &>/dev/null; then
	exec bash
else
	echo "No suitable shell or tmux found."
	exit 1
fi
