{ config, enableGUI, lib, pkgs, ... }: lib.mkMerge [
  {
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
    ripgrep
    rsync
    wget
  ];
  environment.variables.EDITOR = "nvim";
  programs.adb.enable = true;
  virtualisation.docker.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
}
(lib.mkIf enableGUI {
  environment.systemPackages = with pkgs; [
    emacs
    gparted
  ];
  hardware.opentabletdriver.enable = true;
  programs.steam.enable = true;
  services.dbus.packages = [ pkgs.dconf pkgs.gcr ];
})
]
