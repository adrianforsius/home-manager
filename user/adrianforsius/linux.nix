{pkgs, ...}:
with pkgs; {
  # qt = {
  #   enable = true;
  #   platformTheme = "xfce";
  #   style = {
  #     name = "adwaita-dark";
  #     package = pkgs.adwaita-qt;
  #   };
  # };

  gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  # home.sessionVariables.EDITOR = lib.mkForce "nano";

  targets.genericLinux.enable = true;
}
