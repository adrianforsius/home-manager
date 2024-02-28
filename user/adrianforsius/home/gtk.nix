{pkgs, ...}: {
  enable = true;
  iconTheme = {
    name = "gruvbox-dark-icons-gtk";
    package = pkgs.gruvbox-dark-icons-gtk;
  };

  font = {
    name = "JetBrains Mono";
    size = 16;
  };

  theme = {
    name = "matcha-dark-pueril";
    package = pkgs.gruvbox-dark-gtk;
  };

  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-enable-animations = 0;
  };

  gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-enable-animations = 0;
  };
}
