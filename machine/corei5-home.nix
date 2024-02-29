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
          # "FiraCode"
          # "Hasklig"
          # "DroidSansMono"
          # "DejaVuSansMono"
          # "iA-Writer"
          # "Meslo"
          # "SourceCodePro"
          # "Inconsolata"
          "JetBrainsMono"
          "NerdFontsSymbolsOnly" # for some apps, you can use this and then any unpatched font
        ];
      })
      vegur
      noto-fonts
    ];
    fontconfig.defaultFonts = {
      # monospace = ["MesloLGS Nerd Font Mono" "Noto Mono"];
      # sansSerif = ["MesloLGS Nerd Font" "Noto Sans"];
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

    xkb.layout = "es,us";
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";

      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 310 51
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

  # services.kmonad = {
  #   enable = true;
  #   keyboards = {
  #     poker4 = {
  #       name = "io";
  #       config = builtins.readFile ./config/kmonad/poker4.kbd;
  #       device = "/dev/input/by-id/usb-Heng_Yu_Technology_Poker_4_Y0000000000000-event-kbd";
  #       defcfg = {
  #         # enable = true;
  #         fallthrough = true;
  #         allowCommands = false;
  #       };
  #     };
  #   };
  # };

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  # networking.networkmanager.packages = [ networkmanagerapplet ];
}
