# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules/default.nix
    inputs.home-manager.nixosModules.default
  ];

  # Personal modules
  my.firefox.enable = true;
  # my.gnome.enable = true;
  my.cosmic.enable = true;
  my.nvidia.enable = true;
  my.printing.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.ryan = import ./home.nix;
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ryan";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Build packages with ROCm support by default.
  # Needed for btop.
  nixpkgs.config.rocmSupport = true;

  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Desktop tools/enhancements/apps.
    chatterino2 # Twitch chat client.
    ghostty # Terminal.
    wl-clipboard # Clipboard manager for Wayland.

    # Useful CLI tools/utilities.
    bc # Calculator.
    btop # Resource monitor (alternative to htop).
    delta # Git diff tool.
    fd # Find tool.
    git # Version control system.
    google-cloud-sdk-gce # Google Cloud SDK for GCE.
    hunspell # Spell checker.
    jq # JSON processor.
    libreoffice-qt # LibreOffice with Qt5 support.
    pciutils # PCI utilities.
    ripgrep # Search tool.
    starship # Terminal prompt.
    stow # Symlink manager for dotfiles.
    unzip # Unzip files.
    usbutils # USB utilities.
    wget # Download tool.
    python3 # Python 3 interpreter.
  ];

  # List all packages at /etc/current-system-packages.
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;

  programs.tmux.enable = true;
  programs.zsh.enable = true;
  programs.command-not-found.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable docker. However, not on boot since this should only
  # be for development purposes.
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # Use local time for dual boot compatibility.
  time.hardwareClockInLocalTime = true;

  # Bootloader.
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Enable steam hardware.
  hardware.steam-hardware.enable = true;

  # Enable xbox controller support.
  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
