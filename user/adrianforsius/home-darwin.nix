{pkgs, ...}:
with pkgs; {
  # for non-darwin/nixos
  alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
    };
  };

  home.packages = [
    xquartz
    rectangle
    iterm2
    virtualbox
  ];
}
