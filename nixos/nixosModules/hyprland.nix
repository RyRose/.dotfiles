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
    my.hyprland.bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable bluetooth on hyprland.";
    };
  };

  config = lib.mkIf config.my.hyprland.enable {

    hardware.bluetooth.enable = config.my.hyprland.bluetooth.enable;
    hardware.bluetooth.powerOnBoot = config.my.hyprland.bluetooth.enable;
    services.blueman.enable = config.my.hyprland.bluetooth.enable;

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    services.xserver.enable = true;

    programs.thunar.enable = true;

    # Enable Stylix for Hyprland theming.
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

    stylix.fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    stylix.cursor.package = pkgs.bibata-cursors;
    stylix.cursor.name = "Bibata-Modern-Ice";
    stylix.cursor.size = 24;

    environment.systemPackages = with pkgs; [
      dunst # notification daemon
      hyprpolkitagent # polkit agent for Hyprland
      networkmanagerapplet # network manager applet
      rofi-wayland # application launcher
      swww # wallpaper manager
      waybar # status bar
      wl-clipboard # clipboard manager
      font-awesome # icon font, needed for waybar
      inotify-tools # for watching changes for waybar files
      pavucontrol # volume control
      base16-schemes # base16 color schemes for theming
      noto-fonts
      jetbrains-mono
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      bibata-cursors
      wlogout
      hyprlock # screen locker for Hyprland
      hypridle # idle detection for Hyprland
      hyprshot # screenshot tool for Hyprland
      zathura # PDF viewer
      vlc # media player
      libreoffice # office suite
      swayimg # image viewer
      kitty # terminal emulator, use for images
    ];

    # Enable KDE Connect
    # https://wiki.nixos.org/wiki/KDE_Connect
    programs.kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };

    # Optional, hint Electron apps to use Wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
