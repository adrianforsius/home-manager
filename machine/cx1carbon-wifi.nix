{
  config,
  inputs,
  pkgs,
  ...
}:
{
  sops = {
    # built by sops-nix with its own nixpkgs: the default builds with ours, which has an older Go
    package = inputs.sops-nix.packages.${pkgs.stdenv.hostPlatform.system}.sops-install-secrets;
    defaultSopsFile = ../secrets/wifi.yaml;
    # root-owned copy of the age key, see secrets/README.md
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets.home_psk = { };
    # rendered at activation into /run, never into the nix store
    templates."wifi.env".content = ''
      HOME_PSK=${config.sops.placeholder.home_psk}
    '';
  };

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.templates."wifi.env".path ];
    profiles.home-wifi = {
      connection = {
        id = "äpplarövägen9 (nix)";
        type = "wifi";
        autoconnect = true;
        # prefer this profile over a hand-made one for the same SSID
        autoconnect-priority = 10;
      };
      wifi = {
        mode = "infrastructure";
        ssid = "äpplarövägen9";
      };
      wifi-security = {
        key-mgmt = "wpa-psk";
        psk = "$HOME_PSK";
      };
      ipv4.method = "auto";
      ipv6 = {
        method = "auto";
        addr-gen-mode = "default";
      };
    };
  };
}
