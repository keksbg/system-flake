{ config, ... }:
let
    mkZfsMount = subpool: name: {
        device = "rpool/${subpool}/${name}";
	fsType = "zfs";
	options = [ "zfsutil" ];
    };
    mkNixMount = name: mkZfsMount "nixos" name;
    mkUserDataMount = name: mkZfsMount "userdata" name;
in
{
    fileSystems = {
        "/" = { 
	    device = "none";
	    fsType = "tmpfs";
	};

    "/nix" = mkNixMount "nix";

    "/etc" = mkNixMount "etc";

    "/var" = mkNixMount "var";

    "/var/lib" = mkNixMount "var/lib";

    "/var/log" = mkNixMount "var/log";

    "/var/spool" = mkNixMount "var/spool";

    "/home" = mkUserDataMount "home";

    "/root" = mkUserDataMount "home/root";

    "/home/keksbg" = mkUserDataMount "home/keksbg";

    fileSystems."/boot" =
        { device = "/dev/disk/by-uuid/4864-A6DB";
            fsType = "vfat";
        };
    };
}
