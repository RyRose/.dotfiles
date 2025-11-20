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
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rofi-themes-collection = {
      url = "github:newmanls/rofi-themes-collection/ec731cef79d39fc7ae12ef2a70a2a0dd384f9730";
      flake = false;
    };
    catppuccin-hyprland = {
      url = "github:catppuccin/hyprland/c388ac55563ddeea0afe9df79d4bfff0096b146b";
      flake = false;
    };
    catppuccin-hyprlock = {
      url = "github:catppuccin/hyprlock/f650895064ae80db7c0e095829fce83fd85d0b26";
      flake = false;
    };
    catppuccin-waybar = {
      url = "github:catppuccin/waybar/ee8ed32b4f63e9c417249c109818dcc05a2e25da";
      flake = false;
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
      stylix,
      ...
    }@inputs:
    let
      overlay-nixpkgs =
        system:
        { ... }:
        {
          nixpkgs.overlays = [
            (final: prev: {
              unfree = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
              master = import nixpkgs-master {
                inherit system;
                config.allowUnfree = true;
              };
            })
          ];
        };
      overlay-nixpkgs-x86_64-darwin = overlay-nixpkgs "x86_64-darwin";
      overlay-nixpkgs-aarch64-darwin = overlay-nixpkgs "aarch64-darwin";
      overlay-nixpkgs-x86_64-linux = overlay-nixpkgs "x86_64-linux";
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          overlay-nixpkgs-x86_64-linux
          stylix.nixosModules.stylix
          home-manager.nixosModules.default
          ./hosts/desktop/configuration.nix
        ];
      };

      darwinConfigurations.laptop = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
          inherit self;
        };
        modules = [
          overlay-nixpkgs-aarch64-darwin
          stylix.darwinModules.stylix
          home-manager.darwinModules.default
          ./hosts/laptop/configuration.nix
        ];
      };
    };

}
