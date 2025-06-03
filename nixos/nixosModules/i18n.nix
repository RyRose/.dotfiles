{
  lib,
  config,
  ...
}:

{
  options = {
    my.i18n.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable internationalization (i18n) settings.";
    };
  };

  config = lib.mkIf config.my.i18n.enable {

    # Select US English as the default locale.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11 to US layout.
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

  };
}
