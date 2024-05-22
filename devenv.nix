{pkgs, ...}:
with pkgs; {
  packages = [
    alejandra
    shellcheck
    shfmt
    nil
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
  };
}
