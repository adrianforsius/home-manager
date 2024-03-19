{...}: {
  imports = [
    ./hardware/cx1carbon.nix
  ];
  environment.systemPackages = [
    git
    vim
    curl
    binutils
    pciutils
    coreutils
    psmisc
    usbutils
    dnsutils
    libva-utils
    compsize # btrfs util
    x11_ssh_askpass
    veracrypt
    firmware-manager
    cachix
    gnumake
    killall
    rxvt_unicode
    xclip
    pulseaudio
    pavucontrol
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true; # cupsd printing
  services.earlyoom.enable = true; # out of memory detection
  services.autorandr.enable = true; # autodetect display config
  security.sudo.enable = true;
  security.sudo.execWheelOnly = true;
  # security.sudo.extraConfig = ''
  #   Defaults   timestamp_timeout=-1
  # '';

  time.timeZone = "Europe/Berlin";

  # suggest install package if cmd missing
  programs.command-not-found.enable = true;

  # programs.ssh.startAgent = true;
  programs.dconf.enable = true;
  # Used to adjust the brightness of the screen
  programs.light.enable = true;
  # clight requires a latitude and longitude
  # location.latitude = 38.0;
  # location.longitude = -105.0;
  # Used to automatically adjust brightness and temperature of the screen
  # services.clight.enable = true;

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = [
      powerline-fonts
      source-code-pro
      (nerdfonts.override {
        # holy hell it can take a long time to install everything; strip down
        fonts = [
          "JetBrainsMono"
          "NerdFontsSymbolsOnly" # for some apps, you can use this and then any unpatched font
        ];
      })
      vegur
      noto-fonts
    ];
    fontconfig.defaultFonts = {
      serif = ["Noto Serif"];
    };
  };

  # needed here instead of home-manager so we can run as a user and not root
  programs.wireshark.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autoRepeatDelay = 305;
    autoRepeatInterval = 55;

    xkb.layout = "us,es";
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";

      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 310 51

        # display power management signaling: timeout for screen
        ${pkgs.xorg.xset}/bin/xset dpms 0 0 0
        # disable screen saver with these two options no more sleep
        ${pkgs.xorg.xset}/bin/xset s off
      '';
    };
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = [
        rofi
        polybar
        feh
      ];
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # If you want to use JACK applications, uncomment this
  };

  services.kmonad = {
    enable = true;
    keyboards = {
      poker4 = {
        config = builtins.readFile ./config/kmonad/poker4.kbd;
        device = "/dev/input/by-id/usb-Heng_Yu_Technology_Poker_4_Y0000000000000-event-if01";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
      };
      black-widow = {
        config = builtins.readFile ./config/kmonad/black-widow.kbd;
        device = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_2013-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
      };
    };
  };

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
