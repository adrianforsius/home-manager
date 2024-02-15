{
  pkgs,
  lib,
  ...
}:
with pkgs; {
  # TODO: Enable for darwin/NixOS I don't want to deal with nixGl wrapping
  # for non-darwin/nixos
  programs.alacritty = {
    enable = true;
    # TODO: Themeing
    settings = {
      cursor.vi_mode_style = "Underline";
      env.TERM = "xterm-256color";
      font.bold.style = "Bold";
      font.bold_italic.style = "Bold Italic";
      font.italic.style = "Italic";
      font.normal.family = "MesloLGS Nerd Font Mono";
      font.normal.style = "Regular";
      live_config_reload = true;
      scrolling.history = 5000;
      shell.program = "${pkgs.zsh}/bin/zsh";
      window.decorations = "full";
      window.dynamic_title = true;
      window.opacity = 0.9;
    };
  };
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark";
  };
  # TOOD: Find better solution
  programs.git.signing.key = lib.mkForce "1FD1903A55AC5731";

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

  services.network-manager-applet.enable = true;
}
