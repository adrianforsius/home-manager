{pkgs, ...}: {
  enable = true;
  iconTheme = {
    name = "adwaita";
    # package = pkgs.xfce.papirus-dark-icon-theme;
    package = pkgs.xfce.xfce4-icon-theme;
  };
  theme = {
    name = "matcha-dark-pueril";
    package = pkgs.matcha-gtk-theme;
  };
  gtk3.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };
  gtk4.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };
}
