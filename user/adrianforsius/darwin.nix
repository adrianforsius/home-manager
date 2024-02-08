{lib, ...}: {
  users.users.adrianforsius = {
    home = "/Users/adrianforsius";
    shell = pkgs.zsh;
  };

  home.packages = lib.mkAfter [
    xquartz
    rectangle
    iterm2
    virtualbox
  ];
}
