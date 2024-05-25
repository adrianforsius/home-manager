{
  pkgs,
  config,
  ...
}:
with pkgs; {
  # TODO: Enable for darwin/NixOS I don't want to deal with nixGl wrapping
  # for non-darwin/nixos
  # programs.alacritty = {
  #   enable = true;
  #   # TODO: Themeing
  #   settings = {
  #     cursor.vi_mode_style = "Underline";
  #     env.TERM = "xterm-256color";
  #     font.bold.style = "Bold";
  #     font.bold_italic.style = "Bold Italic";
  #     font.italic.style = "Italic";
  #     font.normal.family = "MesloLGS Nerd Font Mono";
  #     font.normal.style = "Regular";
  #     live_config_reload = true;
  #     scrolling.history = 5000;
  #     shell.program = "${pkgs.zsh}/bin/zsh";
  #     window.decorations = "full";
  #     window.dynamic_title = true;
  #     window.opacity = 0.9;
  #   };
  # };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''IdentityFile ~/.ssh/id_ed25519'';
  };

  programs.i3status = {
    enable = true;
    modules = {
      ipv6.enable = false;
      "volume master" = {
        position = 1;
        settings = {
          format = "♪ %volume";
          format_muted = "♪ muted (%volume)";
          device = "default";
        };
      };
      "load".enable = false;
      "disk /".enable = false;
      "battery all".enable = false;
      "ethernet _first_".enable = false;
    };
  };

  home.packages = [
    teams-for-linux
    whatsapp-for-linux
    xclip
    xsel
    pacman
    pamixer
    maim
    xdotool
    # Keeping for reference:
    # (callPackage ./home/package/cerebro {})
  ];

  programs.zsh.shellAliases = {
    pbcopy = "xsel --clipboard --input";
    pbpaste = "xsel --clipboard --output";
    open = "xdg-open";
  };

  # systemd.user.paths = {
  #   kmonad-poker4 = {
  #     Unit = {
  #       Description = "KMonad trigger for poker4";
  #     };
  #     Path = {
  #       PathExists = "/dev/input/by-id/usb-Heng_Yu_Technology_Poker_4_Y0000000000000-event-kbd";
  #       Unit = "kmonad-poker4.path";
  #     };
  #     Install = {
  #       WantedBy = ["default.target"];
  #     };
  #   };
  # };
  #
  # systemd.user.services = {
  #   kmonad-poker4 = {
  #     Unit = {
  #       Description = "KMonad for poker4";
  #     };
  #     Service = {
  #       ExecStart = "kmonad %E/kmonad/poker4.kbd";
  #       Restart = "always";
  #       RestartSec = 3;
  #       Nice = "-20";
  #     };
  #     Install = {
  #       WantedBy = ["default.target"];
  #     };
  #   };
  # };

  gtk = import ./home/gtk.nix {inherit pkgs lib;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  xsession = import ./home/xsession.nix {inherit config lib;};

  services.network-manager-applet.enable = true;
}
