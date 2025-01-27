#!/usr/bin/env bash

if [ ! -e ~/.config/nixos/configuration.nix ]; then
    echo "~/.config/nixos/configuration.nix does not exist, stow $(home) to make available"
    exit 1
fi

set -eux

sudo nixos-rebuild switch \
    -I "nixos-config=${HOME}/.config/nixos/configuration.nix" \
    -I "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" \
    -I "/nix/var/nix/profiles/per-user/root/channels" \
    --flake "${HOME}/.dotfiles/home/.config/nixos"
