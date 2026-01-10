# Needed for homebrew:
# You currently have the following primary‐user‐requiring options set:
# * `homebrew.enable`
# To continue using these options, set `system.primaryUser` to the name
# of the user you have been using to run `darwin-rebuild`. In the long
# run, this setting will be deprecated and removed after all the
# functionality it is relevant for has been adjusted to allow
# specifying the relevant user separately, moved under the
# `users.users.*` namespace, or migrated to Home Manager.

{ ... }:
{
  system.primaryUser = "ryan";
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
      "nikitabobko/tap" # For aerospace.
      "th-ch/youtube-music" # YouTube Music desktop app.
    ];
    brews = [
      "copilot"
      "docker" # Docker CLI.
      "ghcup" # Haskell toolchain manager.
      "node" # Node.js.
    ];
    casks = [
      "aerospace" # Tiling window manager for macOS.
      "betterdisplay"
      "bitwarden" # Password manager.
      "calibre" # E-book management software.
      "crossover" # Run Windows applications on macOS.
      "docker-desktop" # Docker for Mac.
      "firefox" # Web browser.
      "font-jetbrains-mono-nerd-font" # Nerd Font for development.
      "ghostty" # Terminal emulator.
      "google-chrome" # Web browser.
      "intellij-idea-ce" # IDE for Java and other languages.
      "obsidian" # Markdown-based note-taking app.
      "plex" # Media server and client.
      "rectangle" # Window management app.
      "steam" # Gaming platform.
      "tailscale-app" # VPN service.
      "youtube-music" # YouTube Music desktop app.
    ];
  };
}
