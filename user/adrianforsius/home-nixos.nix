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
  # TOOD: Find better solution
  # programs.git.signing.key = lib.mkForce "1FD1903A55AC5731";

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

  gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  xsession = import ./home/xsession.nix {inherit config;};

  services.network-manager-applet.enable = true;
}
