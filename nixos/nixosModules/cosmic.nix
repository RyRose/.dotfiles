{
  lib,
  config,
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

    # https://nixos.org/manual/nixos/stable/release-notes#sec-release-25.05-highlights
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
