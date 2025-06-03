{ ... }:

{
  imports = [
    ./firefox.nix
    ./gnome.nix
    ./cosmic.nix
    ./nvidia.nix
    ./printing.nix
    ./current_system_packages.nix
    ./flakes.nix
    ./i18n.nix
    ./nixgc.nix
  ];
}
