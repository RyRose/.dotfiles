{
  description = "Flake for installing dependencies to set up dotfiles.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs
    }:
    let
      system = "x86_64-linux"; # Replace with your system if needed
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default =
                import ./shell.nix { inherit pkgs; };
    };
}
