{
  description = ''
    Home-manager only config
    sgoetz@wenceslaus
    x86_64-linux
  '';
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    agent-of-empires = {
      url = "github:agent-of-empires/agent-of-empires";
    };
  };
  outputs = inputs: {
    homeConfigurations.sgoetz = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
        overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./modules/sgoetz/home.nix
        ./modules/settings.nix
      ];
    };
  };
}
