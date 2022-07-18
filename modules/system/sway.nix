{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      bemenu
      imv
      libnotify
      mpv
      slurp
      sway-contrib.grimshot
      swaybg
      swayidle
      swaylock
      waybar
      wl-clipboard
      wlogout
    ];
    wrapperFeatures = {
      gtk = true;
    };
  };
  programs.waybar.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
