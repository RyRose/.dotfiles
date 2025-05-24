{
  description = "My NixOS configurations.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
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
      nix-darwin,
      ...
    }@inputs:
    let
      overlay-nixpkgs = system: final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        master = import nixpkgs-master {
          inherit system;
          config.allowUnfree = true;
        };
      };
      overlay-nixpkgs-darwin = overlay-nixpkgs "x86_64-darwin";
      overlay-nixpkgs-linux = overlay-nixpkgs "x86_64-linux";
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          (
            { ... }:
            {
              nixpkgs.overlays = [ overlay-nixpkgs-linux ];
            }
          )
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.default
        ];
      };

      darwinConfigurations.laptop = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          inherit self;
        };
        modules = [
          (
            { ... }:
            {
              nixpkgs.overlays = [ overlay-nixpkgs-darwin ];
            }
          )
          ./hosts/laptop/configuration.nix
          home-manager.darwinModules.default
        ];
      };
    };

}
