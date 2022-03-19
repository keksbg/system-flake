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
	zfs = {
	    devNodes = "/dev/";
	    enableUnstable = true;
	};
	initrd.supportedFilesystems = [ "zfs" ];
  	kernelModules = [ "kvm-intel" ];
	supportedFilesystems = [ "zfs" ];
	# kernelPackages = lib.mkForce (pkgs.linuxPackagesFor pkgs.me.linux-lava);
    };
}
