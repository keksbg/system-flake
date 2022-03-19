{ config, lib, pkgs, ...}: {
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
	initrd.supportedFilesystems = [ "zfs" ];
  	kernelModules = [ "kvm-intel" ];
	supportedFilesystems = [ "zfs" ];
	zfs.devNodes = "/dev/";
	kernelPackages = lib.mkForce (pkgs.linuxPackagesFor pkgs.me.linux-lava);
    };
}
