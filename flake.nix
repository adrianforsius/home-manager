{
  description = "Home Manager configuration of adrianforsius";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv/latest";
    # (builtins.getFlake "./flake/cerebro/flake.nix").packages.x86_64-linux.default)
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    devenv,
    ...
  } @ inputs: {
    homeConfigurations."adrianforsius@adrian" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = builtins.attrValues self.overlays;
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        host = "adrian";
        user = {
          name = "adrianforsius";
          home = "/home/adrianforsius";
        };
      };
    };

    homeConfigurations."adrianf@adrian" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-darwin";
        config.allowUnfree = true;
        overlays = builtins.attrValues self.overlays;
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        host = "adrian";
        user = {
          name = "adrianforsius";
          home = "/Users/adrianforsius";
        };
      };
    };

    overlays = {
      extraPackages = final: prev: {
        devenv = inputs.devenv.packages.${prev.system}.devenv;
      };
    };
  };
}
