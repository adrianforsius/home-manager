{pkgs, ...}:
with pkgs; {
  # qt = {
  #   enable = true;
  #   platformTheme = "xfce";
  #   style = {
  #     name = "adwaita-dark";
  #     package = pkgs.adwaita-qt;
  #   };
  # };

  # TODO: Enable for darwin/NixOS I don't want to deal with nixGl wrapping
  # for non-darwin/nixos
  alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
    };
  };

  home.packages = [
    teams-for-linux
    whatsapp-for-linux
    xclip
    xsel
    # xfce.xfce4-terminal # TODO: fix when installed from nix icons gets messed up
    pacman
    # albert
    (callPackage ./home/package/cerebro {})
  ];

  gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  targets.genericLinux.enable = true;
}
