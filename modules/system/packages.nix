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
    ripgrep
    rsync
    sshfs
    virt-manager
    wget
  ];
  environment.variables.EDITOR = "nvim";
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}
(lib.mkIf enableGUI {
  environment.systemPackages = with pkgs; [
    emacs
    gparted
  ];
  hardware.opentabletdriver.enable = true;
  programs.steam.enable = true;
  programs.droidcam.enable = true;
  services.dbus.packages = [ pkgs.dconf pkgs.gcr ];
})
]
