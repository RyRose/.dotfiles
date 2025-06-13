{
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    my.xdg.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable xdg default configuration.";
    };
  };

  config = lib.mkIf config.my.xdg.enable {
    xdg.enable = true;
    xdg.userDirs.enable = true;
  };
}
