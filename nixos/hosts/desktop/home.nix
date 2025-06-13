{ ... }:

{
  imports = [
    ../../homeManagerModules/default.nix
  ];

  my.xdg.enable = true;
  my.neovim.enable = true;
  my.hyprland.enable = true;
  my.hyprland.monitors = [
    {
      name = "DP-3";
      mode = "3440x1440@100";
      position = "0x0";
      scale = "1";
    }
    {
      name = "DP-1";
      mode = "3840x2160@60";
      position = "3440x0";
      scale = "2";
    }
    {
      name = "HDMI-A-1";
      mode = null;
    }
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ryan";
  home.homeDirectory = "/home/ryan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
