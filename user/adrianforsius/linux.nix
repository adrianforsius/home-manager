{
  lib,
  pkgs,
  ...
}:
with pkgs; {
  # qt = {
  #   enable = true;
  #   platformTheme = "xfce";
  #   style = {
  #     name = "adwaita-dark";
  #     package = pkgs.adwaita-qt;
  #   };
  # };

  gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  home.language = import ./home/language.nix {};

  home.packages = lib.mkAfter [
    teams-for-linux
    whatsapp-for-linux
    xclip
    xsel
    # xfce.xfce4-terminal # TODO: fix when installed from nix icons gets messed up
    pacman
    # albert
    (callPackage ./home/package/cerebro {})
  ];
  # home.sessionVariables.EDITOR = lib.mkForce "nano";

  targets.genericLinux.enable = true;
}
