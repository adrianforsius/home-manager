{...}: {
  environment.sessionVariables = {
    GDK_DPI_SCALE = "1.5";
    QT_SCALE_FACTOR = "1.5";
  };

  powerManagement = {
    enable = true;
  };
  services.fwupd.enable = true; # firmware update; run: sudo fwupdmgr update

  # Allow closing lid without going to sleep
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
  '';

  networking = {
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    wireless.interfaces = ["wlan0"];
    wireless.iwd.enable = true;
    networkmanager = {
      enable = false;
      # wifi.backend = "iwd";
      # getting error: ‘network-manager-applet-1.24.0’, is not a NetworkManager plug-in. Those need to have a ‘networkManagerPlugin’ attribute.
      # just commenting for now 2022-05-30
      #packages = with pkgs.stable; [ networkmanagerapplet ];
      # don't use dhcp dns... use settings below instead
      dns = "none";
    };
    # The global useDHCP flag is deprecated, set to false here.
    useDHCP = false;
    interfaces.wlan0.useDHCP = true;

    # no longer using local dns -- tailscale settings will take
    # over automatically and make sure all dns is safe
    nameservers = ["1.1.1.1" "8.8.8.8"];
    resolvconf.useLocalResolver = false;
    firewall.enable = true;
    firewall.checkReversePath = false; # disable rpfilter so wireguard works
  };

  services.tailscale.enable = true; # p2p mesh vpn with my hosts -- does it override dnscrypt-proxy?

  sound.enable = true;
  security.rtkit.enable = true; # bring in audio
  services.blueman.enable = true;
  #services.xserver.dpi = 160; # fix font sizes in x

  # pipewire brings better audio/video handling
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  services.fprintd.enable = true; # enable fingerprint scanner
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (action.id == "net.reactivated.fprint.device.enroll") {
        return subject.user == "adrianforsius" || subject.user == "root" ? polkit.Result.YES : polkit.Result.NO
      }
    })
  '';

  services.cachix-agent.enable = false;

  virtualisation.vmware.guest.enable = true;
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
    # Don't start on boot; but it will start on-demand
    enableOnBoot = false;
  };
}
