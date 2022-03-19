{ config, lib, pkgs, ...}: {
    boot = {
        efi.canTouchEfiVariables = true;
        loader = {
            grub.enable = true;
	    grub.efiSupport = true;
	    grub.device = "nodev";
	    grub.useOSProber = lib.mkForce false;
        };
	initrd.supportedFilesystems = [ "zfs" ];
  	kernelModules = [ "kvm-intel" ];
	supportedFilesystems = [ "zfs" ];
	zfs.devNodes = "/dev/";
	kernelPackages = lib.mkForce (pkgs.linuxPackagesFor pkgs.me.linux-lava);
    };
}
