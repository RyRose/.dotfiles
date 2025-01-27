#!/usr/bin/env bash

set -eux

sudo nixos-rebuild switch \
    --flake "${HOME}/.dotfiles/home/.config/nixos"
