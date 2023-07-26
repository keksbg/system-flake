{ config, enableGUI, inputs, pkgs, ... }:
let
  discord = pkgs.discord-plugged.override {
    plugins = [
      inputs.cutecord
      inputs.ghostbuster
      inputs.betterfriends
      inputs.channel-typing
    ];
    themes = [ ];
  };

  osu-lazer-bin = inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin.override {
    pipewire_latency = "64/48000";
    gmrun_enable = false;
  };

in
{
  programs.firefox = {
    enable = true;
  };

  home.packages = with pkgs; [
    dconf
    ffmpeg_6-full
    gnupg
    rnix-lsp
    unrar
    unzip
    yt-dlp
  ] ++ lib.optionals enableGUI [
    discord
    easyeffects
    emacs
    feh
    fuse-overlayfs
    gimp
    gnome.file-roller
    helvum
    # inputs.nix-gaming.packages.x86_64-linux.wine-tkg
    inputs.nix-gaming.packages.x86_64-linux.wine-osu
    keepassxc
    kitty
    lutris
    maim
    dwarfs
    me.tetrio-desktop-plus
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs
        obs-vkcapture
      ];
    })
    openjdk17
    pavucontrol
    prismlauncher
    rofi
    tor-browser-bundle-bin
    transmission-gtk
    osu-lazer-bin
    winetricks
    xclip
    xfce.thunar
    xfce.thunar-archive-plugin
  ];
}
