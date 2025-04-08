#!/usr/bin/env bash

if command -v tmux &>/dev/null; then
	tmux new -A -s main
elif command -v zsh &>/dev/null; then
	exec zsh
elif command -v bash &>/dev/null; then
	exec bash
else
	echo "No suitable shell or tmux found."
	exit 1
fi
