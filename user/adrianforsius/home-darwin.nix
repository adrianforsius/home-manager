{pkgs, ...}:
with pkgs; {
  home.packages = [
    xquartz
    rectangle
    iterm2
    virtualbox
  ];
}
