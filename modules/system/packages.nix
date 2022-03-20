{ config, enableGUI, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    efibootmgr
    ccache
    cifs-utils
    git
    htop
    jq
    libarchive
    lf
    msr-tools
    ncdu
    neovim
    nfs-utils
    ntfs3g
    sshfs
    rsync
    wget
  ] ++ lib.optionals enableGUI [
    gparted
  ];
  environment.variables.EDITOR = "nvim";
  programs.adb.enable = true;
}
// (if !enableGUI then {} else {
  hardware.opentabletdriver.enable = true;
  programs.steam.enable = true;
  services.dbus.packages = [ pkgs.dconf pkgs.gcr ];
})
