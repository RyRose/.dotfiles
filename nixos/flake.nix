{
  description = "My NixOS configurations.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      nixpkgs-master,
      ...
    }@inputs:
    let
      system = "x86_64-linux"; # Change this to your system architecture.
      overlay-nixpkgs = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        master = import nixpkgs-master {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          (
            { ... }:
            {
              nixpkgs.overlays = [ overlay-nixpkgs ];
            }
          )
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.default
        ];
      };
    };

}
