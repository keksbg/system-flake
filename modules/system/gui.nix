{ config, lib, pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "NotoSerif" ];
        sansSerif = [ "NotoSans" ];
        monospace = [ "FiraCode" ];
      };
    };
    fonts = with pkgs; [
      cascadia-code
      fira-code
      font-awesome
      font-awesome_4
      hanazono
      material-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      open-sans
      twemoji-color-font
      unifont
    ];
  };
  services.xserver = {
    enable = true;
    autorun = true;
    displayManager = {
      lightdm.enable = lib.mkForce false;
      startx.enable = true;
    };
    videoDrivers = [ "nvidia" ];
    desktopManager.xterm.enable = false;
  };
  hardware.opengl.enable = true;
}
