{ config, enableGUI, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    efibootmgr
    ccache
    cifs-utils
    clang
    docker
    file
    git
    htop
    jq
    libarchive
    lf
    man-db
    man-pages
    msr-tools
    ncdu
    neovim
    nfs-utils
    nix-index
    ntfs3g
    sshfs
    rsync
    wget
  ] ++ lib.optionals enableGUI [
    gparted
  ];
  environment.variables.EDITOR = "nvim";
  programs.adb.enable = true;
  virtualisation.docker.enable = true;
}
// (if !enableGUI then {} else {
  hardware.opentabletdriver.enable = true;
  programs.steam.enable = true;
  services.dbus.packages = [ pkgs.dconf pkgs.gcr ];
})
