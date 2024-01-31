{
  self,
  inputs,
  pkgs,
  lib,
  ...
}: {
  packages = [
    pkgs.rnix-lsp
    (inputs.treefmt-nix.lib.mkWrapper pkgs {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        shellcheck.enable = true;
        shfmt.enable = false;
      };
    })
  ];

  pre-commit = {
    hooks = {
      alejandra.enable = true;
      deadnix.enable = true;
      shfmt.enable = false;
    };

    settings = {
      deadnix.edit = true;
      deadnix.noLambdaArg = true;
    };
  };
}
