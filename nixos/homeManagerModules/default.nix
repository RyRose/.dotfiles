{ config, lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./neovim.nix
    ./xdg.nix
  ];

  # Pre-create these directories to allow for proper stow.
  home.activation.createDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${config.home.homeDirectory}/.local/bin
    run mkdir -p ${config.home.homeDirectory}/.local/share/applications
    run mkdir -p ${config.home.homeDirectory}/.config
    run mkdir -p ${config.home.homeDirectory}/.tmux
  '';
}
