{pkgs, ...}:
with pkgs; {
  xdg.autostart.enable = true;
  xdg.icons.enable = true;
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
    # shell = pkgs.zsh;
    hashedPassword = "$6$jM/t2HIzfLCDj4mn$5PNkU9y3JsRxafqJ9X.l4q4AtAPcQgPBf8dzcmulVsSkZO9rE1CxtmBuJebbWwI3Til.wAyW/PahSifdQTpYh1";
  };

  # home.sessionVariables.EDITOR = lib.mkForce "nano";
}
