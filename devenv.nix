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

  git-hooks = {
    hooks = {
      alejandra.enable = true;
      deadnix.enable = true;
      shfmt.enable = false;
    };
  };
}
