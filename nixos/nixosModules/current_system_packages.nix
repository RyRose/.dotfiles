{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    my.current_system_packages.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable listing current system packages at /etc/current-system-packages.";
    };
  };

  config = lib.mkIf config.my.current_system_packages.enable {
    # List all packages at /etc/current-system-packages.
    environment.etc."current-system-packages".text =
      let
        packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
        sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
      formatted;
  };
}
