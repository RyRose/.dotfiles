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

    # Enable autodiscovery of network printers.
    # https://nixos.wiki/wiki/Printing
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

  };
}
