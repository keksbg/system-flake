{ config, ...}:
let
  mkSnapperConfig = subvol: extra:
  {
    subvolume = subvol;
    fstype = "btrfs";
    extraConfig = extra;
  };
in
{
  services.btrfs.autoScrub.enable = true;
  services.snapper.snapshotInterval = "*-*-* */2:30:00";
  services.snapper.configs = {
    root = mkSnapperConfig "/" "";
    home = mkSnapperConfig "/home" "";
  };
}
