{
  lib,
  config,
  ...
}:

{
  options = {
    my.nixgc.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Nix garbage collection (nixgc) settings.";
    };
  };

  config = lib.mkIf config.my.nixgc.enable {

    # Enable Nix garbage collection.
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

  };
}
