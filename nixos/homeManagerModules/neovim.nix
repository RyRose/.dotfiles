{
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    my.neovim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable neovim.";
    };
  };

  config = lib.mkIf config.my.neovim.enable {

    programs.neovim.defaultEditor = true;
    programs.neovim.enable = true;
    # nvim 0.11 is not yet in stable.
    # programs.neovim.package = pkgs.unstable.neovim-unwrapped;
    programs.neovim.extraPackages = with pkgs; [
      cargo # rust package manager
      codespell
      coursier # Scala package manager
      fd # find tool
      gcc # GNU Compiler Collection
      gnumake # GNU make
      go # Go programming language
      jdk # Java Development Kit
      ktlint # Kotlin linter
      lua # Lua programming language
      luajitPackages.lua-lsp # Lua language server
      luajitPackages.tiktoken_core # https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#optional-dependencies
      luarocks # Lua package manager
      lynx # Text-based web browser
      metals # Scala language server
      nixfmt-rfc-style # Nix formatter
      nodejs # Node.js
      php # PHP programming language
      phpPackages.composer # PHP package manager
      python3 # Python 3 programming language
      python3Packages.pip # Python package manager
      ripgrep # Search tool
      rustc # Rust compiler
      scalafmt # Scala formatter
      sqlfluff # SQL linter and formatter
      stylua # Lua formatter
      tree-sitter # Parser generator tool
      wget # Download tool
    ];

  };
}
