{ config, lib, pkgs, ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = lib.mkForce false;
      };
    };
    zfs = {
      devNodes = "/dev/";
      enableUnstable = true;
    };
    initrd = {
      supportedFilesystems = [ "zfs" ];
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" "hid" "hid_generic" "evdev" "input_core" ];
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/nixos/root@blank
      '';
    };
    kernelModules = [ "kvm-amd" "v4l2loopback" ];
    supportedFilesystems = [ "zfs" ];
    kernelPackages = lib.mkForce (pkgs.linuxPackagesFor pkgs.me.linux-lava);
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
