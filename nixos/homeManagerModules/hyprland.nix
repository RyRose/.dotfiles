{
  config,
  lib,
  pkgs,
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

    programs.kitty.enable = true; # required for the default Hyprland config
    wayland.windowManager.hyprland.enable = true; # enable Hyprland

    wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.ghostty}/bin/ghostty";

      exec-once =
        let
          startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
            ${pkgs.waybar}/bin/waybar &
            ${pkgs.swww}/bin/swww init &
            ${pkgs.swww}/bin/swww img ${./wallpaper.png} &
            ${pkgs.networkmanagerapplet}/bin/nm-applet &
            ${pkgs.dunst}/bin/dunst
          '';
        in
        ''${startupScript}/bin/start'';

      monitor = [
        "DP-3, preferred, auto, 1"
        "DP-1, preferred, auto, 2"
        "HDMI-1, disable"
        # "DP-3, 3440x1440@100, 0x0,    1"
        # "DP-1, 3840x2160@60,  3440x0, 2"
      ];
    };
  };
}
