# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules/default.nix
  ];

  # Personal modules
  my.firefox.enable = true;
  my.nvidia.enable = true;
  my.printing.enable = true;

  # Re-enable once/if cosmic connect is available.
  # https://github.com/pop-os/cosmic-applets/issues/459
  # my.cosmic.enable = true;
  # my.gnome.enable = true;
  my.hyprland.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

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

  # Build packages with ROCm support by default.
  # Needed for btop.
  nixpkgs.config.rocmSupport = true;

  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Desktop tools/enhancements/apps.
    ghostty # Terminal.
    youtube-music # YouTube Music client.
    bitwarden-desktop # Password manager.

    # Useful CLI tools/utilities.
    bc # Calculator.
    btop # Resource monitor (alternative to htop).
    delta # Git diff tool.
    fastfetch # Fast system information tool.
    fd # Find tool.
    git # Version control system.
    google-cloud-sdk-gce # Google Cloud SDK for GCE.
    hunspell # Spell checker.
    jq # JSON processor.
    pciutils # PCI utilities.
    python3 # Python 3 interpreter.
    ripgrep # Search tool.
    starship # Terminal prompt.
    stow # Symlink manager for dotfiles.
    unzip # Unzip files.
    usbutils # USB utilities.
    wget # Download tool.
    foliate # Epub reader.
    calibre # Ebook management software.
  ];

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
