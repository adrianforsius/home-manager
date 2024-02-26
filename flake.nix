{
  description = "Home Manager configuration of adrianforsius";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv/latest";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
      # url = "github:nix-community/nixvim";
      url = "github:adrianforsius/flake-vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    darwin,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) eachSystemMap;
    defaultSystems = [
      # "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    overlays = [
      (final: prev: {
        devenv = inputs.devenv.packages.${prev.system}.devenv;
      })
      (final: prev: {
        neovim = inputs.nixvim.packages.${prev.system}.default;
      })
    ];
    mkSystem = import ./lib/mksystem.nix {inherit overlays nixpkgs inputs;};
  in {
    homeConfigurations."adrianforsius@adrian" = inputs.home-manager.lib.homeManagerConfiguration rec {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        inherit overlays;
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./user/adrianforsius/home.nix
        ./user/adrianforsius/home-linux.nix
      ];

      extraSpecialArgs = {
        user = {
          name = "adrianforsius";
          home = "/home/adrianforsius";
        };
      };
    };

    # TODO: Activate when migrating from arch
    # nixosConfigurations."adrianforsius@adrian" = mkSystem "cx1carbon" {
    #   func = nixpkgs.lib.nixosSystem;
    #   home-manager = inputs.home-manager.nixosModules;
    #   name = "nixos";
    #   arch = "x86_64-linux";
    #   host = "adrian";
    #   user = {
    #     name = "adrianforsius";
    #     home = "/home/adrianforsius";
    #   };
    # };

    nixosConfigurations.vm-intel = mkSystem "vm-intel" {
      config = {
        func = nixpkgs.lib.nixosSystem;
        name = "nixos";
        arch = "x86_64-linux";
        host = "adrian";
        user = {
          name = "adrianforsius";
          home = "/home/adrianforsius";
        };
      };
      home-manager = inputs.home-manager.nixosModules;
    };

    nixosConfigurations.corei5-home = mkSystem "corei5-home" {
      config = {
        func = nixpkgs.lib.nixosSystem;
        name = "nixos";
        arch = "x86_64-linux";
        host = "adrian";
        user = {
          name = "adrianforsius";
          home = "/home/adrianforsius";
        };
      };
      home-manager = inputs.home-manager.nixosModules;
    };

    darwinConfigurations.macbook-pro-m1 = mkSystem "macbook-pro-m1" rec {
      config = {
        func = inputs.darwin.lib.darwinSystem;
        name = "darwin";
        arch = "aarch64-darwin";
        host = "adrian";
        user = {
          name = "adrianforsius";
          home = "/Users/adrianforsius";
        };
      };
      home-manager = inputs.home-manager.darwinModules;
    };

    devShells = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system overlays;
      };
    in {
      default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          (import ./devenv.nix)
        ];
      };
    });
  };
}
