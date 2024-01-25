{
  description = "Home Manager configuration of adrianforsius";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # (builtins.getFlake "./flake/cerebro/flake.nix").packages.x86_64-linux.default)
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations."adrianforsius@adrian" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./home.nix ];

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
      pkgs = import nixpkgs { system = "x86_64-darwin"; config.allowUnfree = true; };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./home.nix ];

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
  };
}
