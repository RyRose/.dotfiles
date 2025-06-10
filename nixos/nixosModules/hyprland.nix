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
      dunst # notification daemon
      kitty # required for the default Hyprland config
      networkmanagerapplet # network manager applet
      rofi-wayland # application launcher
      swww # wallpaper manager
      waybar # status bar
      wl-clipboard # clipboard manager
    ];

    # Optional, hint Electron apps to use Wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
