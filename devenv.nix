{pkgs, ...}:
with pkgs; {
  packages = [
    rnix-lsp
    alejandra
    shellcheck
    shfmt
  ];

  enterShell = ''
    echo "devenv:"
    alejandra --version
  '';

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
