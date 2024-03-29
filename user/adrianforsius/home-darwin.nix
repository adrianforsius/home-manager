{pkgs, ...}:
with pkgs; {
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
      scrolling.smooth = true;
      shell.program = "${pkgs.zsh}/bin/zsh";
      window.decorations = "full";
      window.dynamic_title = true;
      window.opacity = 0.9;
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IdentityFile ~/.ssh/id_ed25519
      UseKeyChain yes
    '';
  };

  home.packages = [
    xquartz
    rectangle
    iterm2
    virtualbox
  ];
}
