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

  home.packages = [
    teams-for-linux
    whatsapp-for-linux
    xclip
    xsel
    # xfce.xfce4-terminal # TODO: fix when installed from nix icons gets messed up
    pacman
    # albert
    (callPackage ./package/cerebro {})
  ];

  gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  targets.genericLinux.enable = true;
}
