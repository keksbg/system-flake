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
	ffmpeg
	gnupg
	rnix-lsp
	unrar
	yt-dlp
    ] ++ lib.optionals enableGUI [
	discord
	gnome.file-roller
	gimp
	maim
	me.tetrio-desktop
	obs-studio
	openjdk17
	pavucontrol
	polymc
	tor-browser-bundle-bin
	transmission-gtk
	inputs.nix-gaming.packages.x86_64-linux.wine-tkg
	inputs.nix-gaming.packages.x86_64-linux.wine-osu
	inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
	winetricks
	xclip
    ];
}
