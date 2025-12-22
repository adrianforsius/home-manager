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
      "wireless _first_" = {
        position = 2;
        settings = {
          format_up = "W:%quality w %bitrate";
          format_down = "W: down";
        };
      };
      "battery 0" = {
        position = 3;
        settings = {
          format = "%status %percentage %remaining %emptytime";
        };
      };
      "memory" = {
        position = 4;
        settings = {
          format = "%used | %available";
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
    wasistlos
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

  gtk = import ./home/gtk.nix {inherit pkgs lib;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  xsession = import ./home/xsession.nix {inherit config lib;};

  services.network-manager-applet.enable = true;
  # services.polybar = rec {
  #   enable = true;
  #   package = pkgs.polybar.override {
  #     # i3GapsSupport = true;
  #     pulseSupport = true;
  #   };
  #   script = "${package}/bin/polybar top &";
  #   config = {
  #     "bar/top" = {
  #       monitor = "\${env:MONITOR:HDMI-1}";
  #       width = "100%";
  #       height = "3%";
  #       radius = 0;
  #       modules-center = "date";
  #     };
  #
  #     "module/date" = {
  #       type = "internal/date";
  #       internal = 5;
  #       date = "%d.%m.%y";
  #       time = "%H:%M";
  #       label = "%time%  %date%";
  #     };
  #   };
  # };
}
