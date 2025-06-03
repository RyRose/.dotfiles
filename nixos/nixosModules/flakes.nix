{
  lib,
  config,
  ...
}:

{
  options = {
    my.flakes.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable flakes support in NixOS.";
    };
  };

  config = lib.mkIf config.my.flakes.enable {

    # Enable the Flakes feature and the accompanying new nix command-line tool
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

  };
}
