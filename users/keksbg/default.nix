{ config, lib, modules, pkgs, ... }: {
  users.users.keksbg = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "audio" "video" "wheel" "docker" "libvirtd" ];
    shell = pkgs.zsh;
    uid = 1001;
    initialHashedPassword = "$1$9fe23fad$.RFy1WSxpTm.7NVJutL48/";
  };
  home-manager.users.keksbg = { config, enableGUI, lib, pkgs, ... }: {
    home = {
      username = "keksbg";
      homeDirectory = "/home/keksbg";
      stateVersion = "21.05";
      keyboard = null;
    };

    imports = with modules.user; [
      ./packages.nix
      direnv
      git
      gpg
      neovim-minimal
      sessionVariables
      zsh
    ] ++ lib.optionals enableGUI [
      bspwm
      dunst
      polybar
      sxhkd
      theming
      xdg
      xorg
    ];

    home.file.".doom.d" = {
      source = ../../res/doom;
      recursive = true;
    };

    home.file.".local/bin/osu" = {
      executable = true;
      source = ../../scripts/osu;
    };

    home.file.".config/kitty/kitty.conf".source = ../../res/kitty.conf;
    home.file.".config/kitty/kitty-theme.conf".source = "${pkgs.kitty-themes}/themes/dark_pride.conf";
    home.file.".config/easyeffects/output/eq.json".source = ../../res/easyeffects-eq.json;

    home.file.".osu".source = config.lib.file.mkOutOfStoreSymlink /mnt/data/games/osu;
    home.file.".local/share/osu".source = config.lib.file.mkOutOfStoreSymlink /mnt/data/games/osu-lazer;
    home.file."Games".source = config.lib.file.mkOutOfStoreSymlink /mnt/data/games;
    home.file."Projects".source = config.lib.file.mkOutOfStoreSymlink /mnt/data/private/Projects;
  };
}
