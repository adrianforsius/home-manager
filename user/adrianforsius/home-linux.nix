{
  pkgs,
  lib,
  ...
}:
with pkgs; {
  home.packages = [
    teams-for-linux
    whatsapp-for-linux
    xclip
    xsel
    # xfce.xfce4-terminal # TODO: fix when installed from nix icons gets messed up
    pacman
    skypeforlinux
    # albert
    # (callPackage ./home/package/cerebro {})
  ];

  # programs.git.signing.signByDefault = lib.mkForce false;
  # programs.git.signing.key = lib.mkForce ""; # TODO: Add me

  systemd.user.paths = {
    kmonad-poker4 = {
      Unit = {
        Description = "KMonad trigger for poker4";
      };
      Path = {
        PathExists = "/dev/input/by-id/usb-Heng_Yu_Technology_Poker_4_Y0000000000000-event-kbd";
        Unit = "kmonad-poker4.path";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };

  systemd.user.services = {
    kmonad-poker4 = {
      Unit = {
        Description = "KMonad for poker4";
      };
      Service = {
        ExecStart = "${pkgs.haskellPackages.kmonad}/bin/kmonad %E/kmonad/poker4.kbd";
        Restart = "always";
        RestartSec = 3;
        Nice = "-20";
      };
      Install = {
        DefaultInstance = "config";
        WantedBy = ["default.target"];
      };
    };
  };

  gtk = import ./home/gtk.nix {inherit pkgs lib;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  targets.genericLinux.enable = true;
}
