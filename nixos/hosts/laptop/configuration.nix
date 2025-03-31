{
  self,
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    # ../../nixosModules/firefox.nix
    inputs.home-manager.darwinModules.default
  ];

  users.users.ryan = {
    name = "ryan";
    home = "/Users/ryan";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.ryan = import ./home.nix;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Desktop tools/enhancements/apps.
    # ghostty # Terminal.
    # gnomeExtensions.pop-shell # Window tiler for gnome.
    # wl-clipboard # Clipboard manager for Wayland.

    # Useful CLI tools/utilities.
    # bc # Calculator.
    # delta # Git diff tool.
    # fd # Find tool.
    # git # Version control system.
    # google-cloud-sdk-gce # Google Cloud SDK for GCE.
    jq # JSON processor.
    # pciutils # PCI utilities.
    # ripgrep # Search tool.
    # starship # Terminal prompt.
    # stow # Symlink manager for dotfiles.
    # unzip # Unzip files.
    # usbutils # USB utilities.
    # wget # Download tool.
    # libreoffice-qt # LibreOffice with Qt5 support.
    # hunspell # Spell checker.

    btop # Resource monitor (alternative to htop).
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
