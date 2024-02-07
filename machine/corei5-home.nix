{pkgs, ...}:
with pkgs; {
  environment.systemPackages = [
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
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  services.locate = {
    enable = true; # periodically update locate db
    localuser = null;
    package = mlocate;
  };
  #services.timesyncd.enable = true;
  services.printing.enable = true; # cupsd printing
  services.earlyoom.enable = true; # out of memory detection
  services.autorandr.enable = true; # autodetect display config
  security.sudo.enable = true;
  security.sudo.execWheelOnly = true;
  security.sudo.extraConfig = ''
    Defaults   timestamp_timeout=-1
  '';

  # suggest install package if cmd missing
  programs.command-not-found.enable = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.ssh.startAgent = true;
  programs.dconf.enable = true;
  # Used to adjust the brightness of the screen
  programs.light.enable = true;
  # clight requires a latitude and longitude
  location.latitude = 38.0;
  location.longitude = -105.0;
  # Used to automatically adjust brightness and temperature of the screen
  #services.clight.enable = true;

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
          "FiraCode"
          "Hasklig"
          "DroidSansMono"
          "DejaVuSansMono"
          "iA-Writer"
          "JetBrainsMono"
          "Meslo"
          "SourceCodePro"
          "Inconsolata"
          "NerdFontsSymbolsOnly" # for some apps, you can use this and then any unpatched font
        ];
      })
      vegur
      noto-fonts
    ];
    fontconfig.defaultFonts = {
      monospace = ["MesloLGS Nerd Font Mono" "Noto Mono"];
      sansSerif = ["MesloLGS Nerd Font" "Noto Sans"];
      serif = ["Noto Serif"];
    };
  };

  # needed here instead of home-manager so we can run as a user and not root
  programs.wireshark.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    autorun = true;
    defaultDepth = 24;
    xkbOptions = "caps:escape";
    # Setup a graphical login
    displayManager = {
      lightdm.enable = true;
    };
    # Keyboard
    # layout = "us";
    autoRepeatDelay = 265;
    autoRepeatInterval = 20;

    # Enable touchpad support
    libinput = {
      enable = true;
      touchpad.accelSpeed = "0.7";
      touchpad.naturalScrolling = true;
      touchpad.middleEmulation = true;
      touchpad.tapping = true;
      touchpad.scrollMethod = "twofinger";
      #touchpad.disableWhileTyping = true;
    };
  };
}
