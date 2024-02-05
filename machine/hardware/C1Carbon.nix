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

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
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
    cpu.intel.updateMicrocode = true;
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
}
