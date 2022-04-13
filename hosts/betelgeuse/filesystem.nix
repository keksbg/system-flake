{ config, ... }:
let
  mkZfsMount = volume: name: {
    device = "rpool/${volume}/${name}";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };
  mkNixMount = name: mkZfsMount "nixos" name;
  mkUserDataMount = name: mkZfsMount "userdata" name;
in
{
  fileSystems = {

    "/" = mkNixMount "root";

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
      device = "/dev/disk/by-uuid/4FEC-1921";
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
  };

  swapDevices = [];
}
