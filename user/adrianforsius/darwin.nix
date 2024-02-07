{lib, ...}: {
  home.packages = lib.mkAfter [
    xquartz
    rectangle
    iterm2
  ];
}
