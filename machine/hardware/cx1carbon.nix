{pkgs, ...}: {
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["mem_sleep_default=deep" "nvme.noacpi=1" "net.ifnames=0"];
    initrd.checkJournalingFS = false;
    supportedFilesystems = ["btrfs"];
    tmp.cleanOnBoot = true;
    tmp.useTmpfs = true;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBQNTY-512G-1001_20124F807325_1-part8";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [];

  hardware = {
    enableAllFirmware = true;
    # video.hidpi.enable = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa.drivers
      ];
    };
    pulseaudio = {
      enable = false;
      #package = pkgs.pulseaudioFull; # needed for bluetooth audio
    };
    # no bluetooth on boot
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s26f7u3.useDHCP = lib.mkDefault true;
  networking.wireless.environmentFile = "/run/secrets/wireless.env";
  networking.wireless.networks.norrberget8-dark-knight-2 = {
    auth = ''
      key_mgmt=WPA-PSK
      eap=PEAP
      identity="quad-home"
      password="@HOME_PASSWORD@"
    '';
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
