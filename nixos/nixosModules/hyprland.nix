{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    my.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprland.";
    };
  };

  config = lib.mkIf config.my.hyprland.enable {
    programs.hyprland.enable = true; # enable Hyprland

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    environment.systemPackages = with pkgs; [
      kitty
      # required for the default Hyprland config
      waybar # status bar
      swww # wallpaper manager
      dunst
      wl-clipboard # clipboard manager
      rofi-wayland # application launcher
      networkmanagerapplet # network manager applet
      dunst # notification daemon
    ];

    # Optional, hint Electron apps to use Wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
