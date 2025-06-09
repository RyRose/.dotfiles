{ ... }:

{
  imports = [
    ./cosmic.nix
    ./current_system_packages.nix
    ./firefox.nix
    ./flakes.nix
    ./gnome.nix
    ./hyprland.nix
    ./i18n.nix
    ./nixgc.nix
    ./nvidia.nix
    ./printing.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
