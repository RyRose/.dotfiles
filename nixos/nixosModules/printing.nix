{
  lib,
  config,
  ...
}:

{
  options = {
    my.printing.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable printing.";
    };
  };

  config = lib.mkIf config.my.printing.enable {

    # Enable CUPS to print documents.
    services.printing.enable = true;
    # Make stateless to address bug:
    # https://github.com/NixOS/nixpkgs/issues/272907
    services.printing.stateless = true;

    # Enable autodiscovery of network printers.
    # https://nixos.wiki/wiki/Printing
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

  };
}
