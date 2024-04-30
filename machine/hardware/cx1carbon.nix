{
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["uhci_hcd" "ehci_pci" "ata_piix" "ahci" "pata_jmicron" "firewire_ohci" "usbhid" "usb_storage" "floppy" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  # boot.loader.grub.device = "/dev/disk/by-id/nvme-WDC_PC_SDBQNTY-512G-1001_201224F807325";
  boot.loader.systemd-boot.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-id/nvme-WDC_PC_SDBQNTY-512G-1001_201224F807325_1-part1";
    fsType = "ext4";
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-id/nvme-WDC_PC_SDBQNTY-512G-1001_201224F807325_1-part8";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-id/nvme-WDC_PC_SDBQNTY-512G-1001_201224F807325_1-part2";}
  ];

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
      identity="carbon-home"
      password="@HOME_PASSWORD@"
    '';
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.enable = true;
  sound.enable = true;
  bluetooth.enable = true;
  bluetooth.powerOnBoot = true;
  security.rtkit.enable = true; # bring in audio
}
