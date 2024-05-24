{pkgs, ...}:
with pkgs; {
  imports = [
    ./hardware/corei5-home.nix
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
    i3lock

    libreoffice-qt
    hunspell
    hunspellDicts.sv_SE
    hunspellDicts.en_US
    hunspellDicts.es_MX
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  # services.locate = {
  #   enable = true; # periodically update locate db
  #   localuser = null;
  #   package = mlocate;
  # };
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

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

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
  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";
    };

    xserver = {
      enable = true;
      autoRepeatDelay = 305;
      autoRepeatInterval = 55;

      xkb.layout = "us,se,es";
      displayManager = {
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
          i3lock
        ];
      };

      xautolock = {
        enable = true;
        locker = "${pkgs.i3lock}/bin/i3lock";
        time = 10; # minutes
      };
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

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  # networking.networkmanager.packages = [ networkmanagerapplet ];
}
