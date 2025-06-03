{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    my.cosmic.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable cosmic desktop environment.";
    };
  };

  config = lib.mkIf config.my.cosmic.enable {

    environment.systemPackages = with pkgs; [
      wl-clipboard # Clipboard manager for Wayland.
    ];

    # https://nixos.org/manual/nixos/stable/release-notes#sec-release-25.05-highlights
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # Enable geoclue2 to address shutdown issue.
    # https://github.com/pop-os/cosmic-settings/issues/1154
    services.geoclue2.enable = true;
  };
}
