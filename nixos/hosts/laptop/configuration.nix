{
  self,
  inputs,
  ...
}:
{

  imports = [
    inputs.home-manager.darwinModules.default
    ./homebrew.nix
    ./packages.nix
  ];

  # Disable nix management for determinate nix compatibility.
  nix.enable = false;

  # Enable sudo with touch ID.
  security.pam.services.sudo_local.touchIdAuth = true;

  # Disable natural scrolling.
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

  # Enable ctrl + cmd to drag windows.
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;

  # Disable press and hold for keys.
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

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
