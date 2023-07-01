{ config, ...}:
let
  mkSnapperConfig = subvol:
  {
    SUBVOLUME = subvol;
    FSTYPE = "btrfs";
  };
in
{
  services.btrfs.autoScrub.enable = true;
  services.snapper.snapshotInterval = "*-*-* */2:30:00";
  services.snapper.configs = {
    root = mkSnapperConfig "/";
    home = mkSnapperConfig "/home";
  };
}
