{
  pkgs,
  config,
  ...
}: {
  xdg.autostart.enable = true;
  xdg.icons.enable = true;

  nix = {
    # use unstable nix so we can access flakes
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    # public binary cache that I use for all my derivations. You can keep
    # this, use your own, or toss it. Its typically safe to use a binary cache
    # since the data inside is checksummed.
    settings = {
      trusted-users = ["adrianforsius" "root" "@wheel"];
      allowed-users = ["@wheel"];
      substituters = [
        "https://cache.garnix.io"
        "https://cache.nixos.org"
        # "https://adrianforsius.cachix.org"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        # "adrianforsius.cachix.org-1:dqiGV3J707B/aFdb8YS2u59G50jcgNUabpcw1vOq/e4="
      ];
    };

    # TODO: Enable when more stable
    # gc = {
    #   automatic = true;
    #   options = "--max-freed $((30*8*1024**3))" # 30 GB
    # };
  };

  stylix = import ./home/stylix.nix {inherit pkgs config;};

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

  programs.zsh.enable = true;
  users.users.adrianforsius = {
    isNormalUser = true;
    home = "/home/adrianforsius";
    extraGroups = ["docker" "wheel" "networkmanager"];
    shell = pkgs.zsh;
    hashedPassword = "$6$jM/t2HIzfLCDj4mn$5PNkU9y3JsRxafqJ9X.l4q4AtAPcQgPBf8dzcmulVsSkZO9rE1CxtmBuJebbWwI3Til.wAyW/PahSifdQTpYh1";
  };
}
