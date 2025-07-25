{
  self,
  pkgs,
  inputs,
  config,
  ...
}:
{

  imports = [
    inputs.home-manager.darwinModules.default
  ];

  # Disable nix management for determinate nix compatibility.
  nix.enable = false;

  # Needed for homebrew:
  # You currently have the following primary‐user‐requiring options set:
  # * `homebrew.enable`
  # To continue using these options, set `system.primaryUser` to the name
  # of the user you have been using to run `darwin-rebuild`. In the long
  # run, this setting will be deprecated and removed after all the
  # functionality it is relevant for has been adjusted to allow
  # specifying the relevant user separately, moved under the
  # `users.users.*` namespace, or migrated to Home Manager.
  system.primaryUser = "ryan";
  homebrew = {
    enable = true;
    casks = [
      "bitwarden"
      "firefox"
      "ghostty"
      "plex"
      "rectangle"
      "steam"
    ];
  };

  # Enable sudo with touch ID.
  security.pam.services.sudo_local.touchIdAuth = true;

  # Enable natural scrolling.
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;

  system.defaults.dock.persistent-apps = [
    { app = "/Applications/Firefox.app"; }
    { app = "/Applications/Ghostty.app"; }
    { app = "/Applications/Bitwarden.app"; }
  ];

  users.users.ryan = {
    name = "ryan";
    home = "/Users/ryan";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.ryan = import ./home.nix;
  };

  environment.systemPackages = with pkgs; [

    # Useful CLI tools/utilities.
    btop # Resource monitor (alternative to htop).
    delta # Git diff tool.
    fd # Find tool.
    git # Version control system.
    jq # JSON processor.
    ripgrep # Search tool.
    starship # Terminal prompt.
    stow # Symlink manager for dotfiles.
    tmux
    unzip # Unzip files.
    wget # Download tool.
  ];

  programs.tmux.enable = true;

  system.defaults.dock.autohide = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
