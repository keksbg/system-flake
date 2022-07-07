{ config, ... }:
let
  mkBtrfsMount = subvol: extraOptions:
    {
      device = "/dev/mapper/btrfs";
      fsType = "btrfs";
      options = [ "subvol=${subvol}" "compress=zstd" ] ++ extraOptions;
    };
in
{
  fileSystems = {

    "/" = mkBtrfsMount "root" [];
    "/home" = mkBtrfsMount "home" [];
    "/nix" = mkBtrfsMount "nix" [ "noatime" ];

    "/boot" = {
      device = "/dev/disk/by-uuid/08AA-B7FE";
      fsType = "vfat";
    };

    "/mnt/data" = {
      device = "bigdata";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };
  };

  swapDevices = [];
}
