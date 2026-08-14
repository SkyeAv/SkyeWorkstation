{
  description = ''
    SL Goetz NixOS
    skyeav@skyetop
    26.05 (Yarara) x86_64
    03-19-2026
  '';
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    agent-of-empires = {
      url = "github:agent-of-empires/agent-of-empires";
    };
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake.nixosConfigurations.skyeav = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/hardware.nix
          ./modules/skyeav/user.nix
          inputs.home-manager.nixosModules.home-manager
          ./modules/skyeav/home.nix
          ./modules/settings.nix
          ./modules/kernel.nix
          ./modules/services.nix
          ./modules/virtualization.nix
          ./modules/global.nix
          ./modules/networking.nix
          inputs.nix-index-database.nixosModules.default
        ];
      };
    };
}
