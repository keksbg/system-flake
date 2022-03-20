{ config, enableGUI, inputs, pkgs, ... }:
let
    discord = pkgs.discord-plugged.override {
	plugins = [];
	themes = [];
    };
in {
    programs.firefox = {
	enable = true;
    };

    home.packages = with pkgs; [
        dconf
	ffmpeg
	gnupg
	rnix-lsp
        alacritty
	unrar
	yt-dlp
    ] ++ lib.optionals enableGUI [
	discord
        easyeffects
        feh
        rofi
	gnome.file-roller
	gimp
        helvum
	maim
	me.tetrio-desktop
	obs-studio
	openjdk17
	pavucontrol
	polymc
	tor-browser-bundle-bin
	transmission-gtk
	inputs.nix-gaming.packages.x86_64-linux.wine-tkg
        # inputs.nix-gaming.packages.x86_64-linux.wine-osu
	inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
	winetricks
	xclip
        xfce.thunar
        xfce.thunar-archive-plugin
    ];
}
