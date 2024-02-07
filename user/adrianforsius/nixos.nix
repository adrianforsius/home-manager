{
  # lib,
  pkgs,
  ...
}: {
  gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  home.language = import ./home/language.nix {};

  home.packages = lib.mkAfter [
    teams-for-linux
    whatsapp-for-linux
    xclip
    # xfce.xfce4-terminal # TODO: fix when installed from nix icons gets messed up
    pacman
    # albert
    (callPackage ./home/package/cerebro {})
    virtualbox
  ];

  # home.sessionVariables.EDITOR = lib.mkForce "nano";
}
