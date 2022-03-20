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

        "/boot" = { 
            device = "/dev/disk/by-uuid/4864-A6DB";
                fsType = "vfat";
            };

        "/mnt/pxmx" = {
            device = "//192.168.1.22/public";
            fsType = "cifs";
            options = [
                "nofail"
                "uid=keksbg"
                "noperm"
                "guest"
            ];
        };

        "/mnt/old" = {
            device = "/dev/disk/by-uuid/9ebb5521-27c0-44b8-82b1-cd9a80edf257";
            fsType = "ext4";
            options = [
              "defaults"
              "nofail"
            ];
        };
    };

    swapDevices = [
        {
            device = "/dev/rpool/swap";
            randomEncryption = {
                cipher = "aes-xts-plain64";
                enable = true;
                source = "/dev/urandom";
            };
            options = [ "discard" ];
        }
    ];
}
