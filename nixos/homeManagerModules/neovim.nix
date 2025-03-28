{ pkgs, ... }:
{
  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
  # nvim 0.11 is only in master.
  programs.neovim.package = pkgs.master.neovim-unwrapped;
  programs.neovim.extraPackages = with pkgs; [
    cargo # rust package manager
    fd # find tool
    gcc # GNU Compiler Collection
    gnumake # GNU make
    go # Go programming language
    jdk # Java Development Kit
    julia # Julia programming language
    lua # Lua programming language
    luajitPackages.lua-lsp # Lua language server
    luarocks # Lua package manager
    lynx # Text-based web browser
    nixfmt-rfc-style # Nix formatter
    nodejs # Node.js
    php # PHP programming language
    phpPackages.composer # PHP package manager
    python3 # Python 3 programming language
    python312Packages.tiktoken # OpenAI tokenizer library
    python3Packages.pip # Python package manager
    ripgrep # Search tool
    rustc # Rust compiler
    sqlfluff # SQL linter and formatter
    stylua # Lua formatter
    tree-sitter # Parser generator tool
    wget # Download tool
  ];
}
