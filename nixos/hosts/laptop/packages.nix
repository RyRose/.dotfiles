# NixOS system packages for laptop host.

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ansible
    binutils # GNU binary utilities.
    btop # Resource monitor (alternative to htop).
    delta # Git diff tool.
    direnv # Environment variable manager.
    fd # Find tool.
    fzf # Fuzzy finder.
    git # Version control system.
    glow # Markdown viewer.
    google-cloud-sdk # gcloud
    jq # JSON processor.
    ripgrep # Search tool.
    sd # Streamlined alternative to sed.
    starship # Terminal prompt.
    stow # Symlink manager for dotfiles.
    uv
    unzip # Unzip files.
    wget # Download tool.
    zoxide # Smart cd command.
  ];
}
