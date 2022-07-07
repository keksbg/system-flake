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
    initrd = {
      luks.devices."btrfs" = {
        device = "/dev/disk/by-uuid/063972fb-4dd0-40b8-b0bb-083a9a834515";
        postOpenCommands = ''
          mkdir /tmpmnt
          mount /dev/mapper/btrfs /tmpmnt
          btrfs subvol delete root
          btrfs subvol snapshot blank root
          umount /tmpmnt && rm -rf /tmpmnt
        '';
      };
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" "hid" "hid_generic" "evdev" "input_core" ];
    };
    kernelModules = [ "kvm-intel" ];
  };
}
