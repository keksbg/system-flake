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
	supportedFilesystems = [ "zfs" ];
	kernelPackages = lib.mkForce (pkgs.linuxPackagesFor pkgs.me.linux-lava);
    };
}
