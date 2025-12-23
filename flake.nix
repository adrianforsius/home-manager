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
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
      # url = "github:nix-community/nixvim";
      url = "github:adrianforsius/flake-vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld.url = "github:Mic92/nix-ld";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # git hooks used for the devShell
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (flake-utils.lib) eachSystemMap;
      defaultSystems = [
        # "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      overlays = [
        (_: prev: {
          neovim = inputs.nixvim.packages.${prev.stdenv.hostPlatform.system}.default;
        })
      ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs defaultSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
      mkSystem = import ./lib/mksystem.nix { inherit overlays nixpkgs inputs; };
    in
    {
      homeConfigurations."adrianforsius@adrian" = inputs.home-manager.lib.homeManagerConfiguration {
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
      nixosConfigurations.cx1carbon = mkSystem "cx1carbon" {
        config = {
          func = nixpkgs.lib.nixosSystem;
          name = "nixos";
          arch = "x86_64-linux";
          host = "adrian";
          user = {
            name = "adrianforsius";
            home = "/home/adrianforsius";
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.kmonad.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
            inputs.nix-ld.nixosModules.nix-ld
          ];
        };
      };

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
          modules = [ inputs.home-manager.nixosModules.home-manager ];
        };
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
          modules = [
            inputs.home-manager.nixosModules.home-manager
            # inputs.kmonad.nixosModules.default
            inputs.stylix.nixosModules.stylix
            inputs.nix-ld.nixosModules.nix-ld
          ];
        };
      };

      darwinConfigurations.macbook-pro-m1 = mkSystem "macbook-pro-m1" {
        config = {
          func = inputs.darwin.lib.darwinSystem;
          name = "darwin";
          arch = "aarch64-darwin";
          host = "adrian";
          user = {
            name = "adrianforsius";
            home = "/Users/adrianforsius";
          };
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.darwinModules.stylix
            inputs.nix-ld.nixosModules.nix-ld
          ];
        };
      };

      # Run the hooks in a sandbox with `nix flake check`.
      # Read-only filesystem and no internet access.
      checks = forEachSupportedSystem (
        { pkgs }:
        {
          pre-commit-check = inputs.git-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
            src = ./.;
            hooks = {
              nixfmt.enable = true;
            };
          };
        }
      );

      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default =
            let
              inherit (self.checks.${pkgs.stdenv.hostPlatform.system}.pre-commit-check) shellHook enabledPackages;
            in
            pkgs.mkShellNoCC {
              inherit shellHook;
              buildInputs = enabledPackages;
              packages = with pkgs; [
                nixd
                cachix
                lorri
                niv
                nixfmt-classic
                statix
                vulnix
                haskellPackages.dhall-nix
              ];
            };
        }
      );
    };
}
