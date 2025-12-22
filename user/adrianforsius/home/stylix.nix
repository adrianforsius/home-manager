{pkgs, ...}: {
  enable = true;
  autoEnable = true;
  polarity = "dark";
  image = ./asset/wallpaper-nix-blue.png;
  base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };
  fonts.sizes = {
    terminal = 17;
    # applications = 12;
    # desktop = 11;
    # popups = 11;
  };
}
