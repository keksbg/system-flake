{ config, lib, modules, pkgs, ...}: {
    users.users.keksbg = {
	isNormalUser = true;
	extraGroups = [ "adbusers" "audio" "video" "wheel" ];
	shell = pkgs.zsh;
	uid = 1001;
	initialHashedPassword = "$1$9fe23fad$.RFy1WSxpTm.7NVJutL48/";
    };
    home-manager.users.keksbg = { config, enableGUI, lib, pks, ...}: {
    	home = {
	    username = "keksbg";
	    homeDirectory = "/home/keksbg";
	    stateVersion = "21.05";
	    keyboard = null;
	};

        imports = with modules.user; [
	    ./packages.nix
	    sessionVariables
	    git
	    gpg
	    neovim-minimal
	    zsh
        ] ++ lib.optionals enableGUI [
	    theming
	    xdg
	    dunst
	    polybar
	    xorg
	    sxhkd
	    bspwm
        ];

        home.file.".local/bin/osu" = {
	    executable = true;
	    source = ../../scripts/osu;
        };
        home.file.".config/alacritty.yml".source = ../../res/alacritty.yml; 
    };
}
