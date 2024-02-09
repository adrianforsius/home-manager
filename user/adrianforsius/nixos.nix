{
  lib,
  pkgs,
  ...
}:
with pkgs; {
  # gtk = import ./home/gtk.nix {inherit pkgs;};

  xdg = import ./home/xdg.nix {inherit pkgs;};

  home.language = import ./home/language.nix {};

  # programs.hyperland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
  # environment.systemPackages = [
  #   rofi-wayland
  #   kitty
  #
  #   waybar
  #   eww
  # ];

  users.users.adrianforsius = {
    isNormalUser = true;
    home = "/home/adrianforsius";
    extraGroups = ["docker" "wheel"];
    shell = pkgs.fish;
    hashedPassword = "$6$jM/t2HIzfLCDj4mn$5PNkU9y3JsRxafqJ9X.l4q4AtAPcQgPBf8dzcmulVsSkZO9rE1CxtmBuJebbWwI3Til.wAyW/PahSifdQTpYh1";
  };

  home.packages = lib.mkAfter [
    teams-for-linux
    whatsapp-for-linux
    xclip
    # xfce.xfce4-terminal # TODO: fix when installed from nix icons gets messed up
    pacman
    # albert
    (callPackage ./home/package/cerebro {})
    virtualbox
  ];

  # home.sessionVariables.EDITOR = lib.mkForce "nano";
}
