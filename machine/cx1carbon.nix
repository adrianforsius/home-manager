{pkgs, ...}: {
  imports = [
    ./hardware/cx1carbon.nix
  ];
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    binutils
    pciutils
    coreutils
    psmisc
    nmap
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
    arandr
    autorandr
    i3lock-fancy
    inetutils

    gomodifytags

    libreoffice-qt
    hunspell
    hunspellDicts.sv_SE
    hunspellDicts.en_US
    hunspellDicts.es_MX

    # gaming related
    mangohud
    protonup
  ];
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  i18n.defaultLocale = "sv_SE.UTF-8";

  services.printing.enable = true; # cupsd printing
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.earlyoom.enable = true; # out of memory detection
  # services.autorandr.enable = true; # autodetect display config
  security.sudo.enable = true;
  security.sudo.execWheelOnly = true;
  # security.sudo.extraConfig = ''
  #   Defaults   timestamp_timeout=-1
  # '';

  time.timeZone = "Europe/Stockholm";

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

  # fonts = {
  #   enableDefaultPackages = true;
  #   fontconfig.enable = true;
  #   fontDir.enable = true;
  #   enableGhostscriptFonts = true;
  #   packages = with pkgs; [
  #     powerline-fonts
  #     source-code-pro
  #     (nerdfonts.override {
  #       # holy hell it can take a long time to install everything; strip down
  #       fonts = [
  #         "JetBrainsMono"
  #         "NerdFontsSymbolsOnly" # for some apps, you can use this and then any unpatched font
  #       ];
  #     })
  #     vegur
  #     noto-fonts
  #   ];
  #   fontconfig.defaultFonts = {
  #     serif = ["Noto Serif"];
  #   };
  # };

  # needed here instead of home-manager so we can run as a user and not root
  programs.wireshark.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable the X11 windowing system.
  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";
    };

    autorandr = {
      enable = true;
      profiles = {
        "home-alt" = {
          fingerprint = {
            HDMI-1 = "00ffffffffffff004c2dcd053432524c2a130103801009782a6041a6564a9c25125054230800a9408180814081009500b30001010101023a801871382d40582c4500a05a0000001e011d007251d01e206e285500a05a0000001e000000fd00323c1e5111000a202020202020000000fc0053796e634d61737465720a2020017802031cf14890041f0514130312230907078301000066030c00100080011d80d0721c1620102c2580a05a0000009e011d8018711c1620582c2500a05a0000009e011d00bc52d01e20b8285540a05a0000001e8c0ad090204031200c405500a05a000000188c0ad08a20e02d10103e9600a05a0000001800000000000000000046";
            eDP-1 = "00ffffffffffff0009e5db0700000000011c0104a51f1178027d50a657529f27125054000000010101010101010101010101010101013a3880de703828403020360035ae1000001afb2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a0043";
          };
          config = {
            eDP-1.enable = false;
            HDMI-1 = {
              enable = true;
              # mode = "3840x2160";
              mode = "1680x1050";
              rate = "60.00";
              primary = true;
              # crtc = 1;
              position = "0x0";
              rotate = "normal";
              # scale = { x = 0.5; y = 0.5;};
            };
          };
          hooks = {
            postswitch = {
              "set-background" = "${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.jpg";
            };
          };
        };
        "home" = {
          fingerprint = {
            HDMI-1 = "00ffffffffffff004c2d520f58485843111f0103804627782aaea5af4f42af260f5054bfef80714f810081c081809500a9c0b300010108e80030f2705a80b0588a00b9882100001e000000fd00184b1e873c000a202020202020000000fc005533324a3539780a2020202020000000ff0048344c523530303435370a2020010d020334f04d611203130420221f105f605d5e23090707830100006d030c002000b83c20006001020367d85dc401788003e30f0104023a801871382d40582c4500b9882100001e023a80d072382d40102c4580b9882100001e04740030f2705a80b0588a00b9882100001e565e00a0a0a0295030203500b9882100001a00000090";
            eDP-1 = "00ffffffffffff0009e5db0700000000011c0104a51f1178027d50a657529f27125054000000010101010101010101010101010101013a3880de703828403020360035ae1000001afb2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a0043";
          };
          config = {
            eDP-1.enable = false;
            HDMI-1 = {
              enable = true;
              # mode = "3840x2160";
              mode = "2560x1440";
              rate = "60.00";
              primary = true;
              crtc = 1;
              position = "0x0";
              rotate = "normal";
              # scale = { x = 0.5; y = 0.5;};
            };
          };
          hooks = {
            postswitch = {
              "set-background" = "${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.jpg";
            };
          };
        };
        "home-mir" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0009e5db0700000000011c0104a51f1178027d50a657529f27125054000000010101010101010101010101010101013a3880de703828403020360035ae1000001afb2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a0043";
            HDMI-1 = "00ffffffffffff004c2d520f58485843111f0103804627782aaea5af4f42af260f5054bfef80714f810081c081809500a9c0b300010108e80030f2705a80b0588a00b9882100001e000000fd00184b1e873c000a202020202020000000fc005533324a3539780a2020202020000000ff0048344c523530303435370a2020010d020334f04d611203130420221f105f605d5e23090707830100006d030c002000b83c20006001020367d85dc401788003e30f0104023a801871382d40582c4500b9882100001e023a80d072382d40102c4580b9882100001e04740030f2705a80b0588a00b9882100001e565e00a0a0a0295030203500b9882100001a00000090";
          };
          config = {
            HDMI-1 = {
              enable = true;
              mode = "1920x1080";
              rate = "60.00";
              # primary = true;
              # crtc = 1;
              # position = "0x0";
              # rotate = "normal";
              # scale = { x = 0.5; y = 0.5;};
            };
            eDP-1 = {
              enable = true;
              mode = "1920x1080";
              rate = "60.00";
              primary = true;
              crtc = 1;
              position = "0x0";
              rotate = "normal";
              # scale = { x = 0.5; y = 0.5;};
            };
          };
          # hooks = {
          #   postswitch = {
          #     "set-background" = "${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.jpg";
          #   };
          # };
        };
        "home-screen" = {
          fingerprint = {
            HDMI-1 = "00ffffffffffff004c2d520f58485843111f0103804627782aaea5af4f42af260f5054bfef80714f810081c081809500a9c0b300010108e80030f2705a80b0588a00b9882100001e000000fd00184b1e873c000a202020202020000000fc005533324a3539780a2020202020000000ff0048344c523530303435370a2020010d020334f04d611203130420221f105f605d5e23090707830100006d030c002000b83c20006001020367d85dc401788003e30f0104023a801871382d40582c4500b9882100001e023a80d072382d40102c4580b9882100001e04740030f2705a80b0588a00b9882100001e565e00a0a0a0295030203500b9882100001a00000090";
          };
          config = {
            HDMI-1 = {
              enable = true;
              # mode = "3840x2160";
              mode = "2560x1440";
              rate = "60.00";
              primary = true;
              crtc = 1;
              position = "0x0";
              rotate = "normal";
              # scale = { x = 0.5; y = 0.5;};
            };
          };
        };
        "default" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0009e5db0700000000011c0104a51f1178027d50a657529f27125054000000010101010101010101010101010101013a3880de703828403020360035ae1000001afb2c80de703828403020360035ae1000001a000000fe00424f452043510a202020202020000000fe004e4531343046484d2d4e36310a0043";
          };
          config = {
            eDP-1 = {
              enable = true;
              mode = "1920x1080";
              rate = "60.00";
              primary = true;
              crtc = 1;
              position = "0x0";
              rotate = "normal";
              # scale = { x = 0.5; y = 0.5;};
            };
          };
        };
      };
    };

    xserver = {
      # dpi = 60;
      enable = true;
      autoRepeatDelay = 305;
      autoRepeatInterval = 55;

      xkb.layout = "us,se,es";
      displayManager = {
        sessionCommands = ''
          ${pkgs.autorandr}/bin/autorandr -c
          ${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.jpg

          ${pkgs.xorg.setxkbmap}/bin/setxkbmap -option compose:ralt
          ${pkgs.xorg.xset}/bin/xset r rate 310 51

          # display power management signaling: timeout for screen
          # ${pkgs.xorg.xset}/bin/xset dpms 0 0 0

          # disable screen saver with these two options no more sleep
          # ${pkgs.xorg.xset}/bin/xset s off
        '';
      };
      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi
          polybar
          feh
          i3lock-fancy
          i3-layout-manager
        ];
      };

      xautolock = {
        enable = true;
        # enableNotifier = true;
        locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy --nofork -p";
        time = 60; # minutes
        extraOptions = ["-corners" "---+" "-cornerdelay" "1" "-cornerredelay" "1" "-cornersize" "20"];
      };
    };
  };

  services.kmonad = {
    enable = true;
    keyboards = {
      poker4 = {
        config = builtins.readFile ./config/kmonad/poker4.kbd;
        device = "/dev/input/by-id/usb-Heng_Yu_Technology_Poker_4_Y0000000000000-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
          # compose.key = "menu";
          # compose.delay = 1000;
        };
      };
      black-widow = {
        config = builtins.readFile ./config/kmonad/black-widow.kbd;
        device = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_2013-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
          # compose.key = "menu";
          # compose.delay = 1000;
        };
      };
    };
  };

  environment.sessionVariables = {
    GDK_DPI_SCALE = "1";
    QT_SCALE_FACTOR = "1";
  };

  powerManagement = {
    enable = true;
  };
  services.fwupd.enable = true; # firmware update; run: sudo fwupdmgr update
  services.tlp.enable = true; # powermanagement helper

  # Allow closing lid without going to sleep
  # services.logind.lidSwitch = "ignore";
  # services.logind.lidSwitch = "suspend-then-hibernate";
  #
  # systemd.services."awake-after-suspend-for-a-time" = {
  #   description = "Sets up the suspend so that it'll wake for hibernation only if not on AC power";
  #   wantedBy = ["suspend.target"];
  #   before = ["systemd-suspend.service"];
  #   environment = {
  #     HIBERNATE_SECONDS = "10";
  #     HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  #   };
  #   script = ''
  #     if [ $(cat /sys/class/power_supply/AC/online) -eq 0 ]; then
  #       curtime=$(date +%s)
  #       echo "$curtime $1" >> /tmp/autohibernate.log
  #       echo "$curtime" > $HIBERNATE_LOCK
  #       ${pkgs.utillinux}/bin/rtcwake -m no -s $HIBERNATE_SECONDS
  #     else
  #       echo "System is on AC power, skipping wake-up scheduling for hibernation." >> /tmp/autohibernate.log
  #     fi
  #   '';
  #   serviceConfig.Type = "simple";
  # };
  #
  # systemd.services."hibernate-after-recovery" = {
  #   description = "Hibernates after a suspend recovery due to timeout";
  #   wantedBy = ["suspend.target"];
  #   after = ["systemd-suspend.service"];
  #   environment = {
  #     HIBERNATE_SECONDS = "10";
  #     HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  #   };
  #   script = ''
  #     curtime=$(date +%s)
  #     sustime=$(cat $HIBERNATE_LOCK)
  #     rm $HIBERNATE_LOCK
  #     if [ $(($curtime - $sustime)) -ge $HIBERNATE_SECONDS ] ; then
  #       systemctl hibernate
  #     else
  #       ${pkgs.utillinux}/bin/rtcwake -m no -s 1
  #     fi
  #   '';
  #   serviceConfig.Type = "simple";
  # };

  networking = {
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    wireless.interfaces = ["wlan0"];
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
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

  security.rtkit.enable = true; # bring in audio
  services.blueman.enable = true;
  #services.xserver.dpi = 160; # fix font sizes in x

  # pipewire brings better audio/video handling
  # services.pipewire = {
  #   enable = true;
  #   alsa = {
  #     enable = true;
  #     support32Bit = true;
  #   };
  #   pulse.enable = true;
  # };

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
