{ lib }:
let
    getName = path: lib.removeSuffix ".nix" (
        lib.last (
	    lib.splitString "/" (
	        builtins.toString path
            )
	)
    );
    mkAttrsFromPaths = paths: builtins.listToAttrs (
        builtins.map (path: {
	    name = getName path;
	    value = path;
	}) paths
    );
in {
    system = mkAttrsFromPaths [
        ./system/audio.nix
        ./system/base.nix
	./system/gui.nix
	./system/home-manager.nix
	./system/input.nix
	./system/kernel.nix
	./system/nix.nix
	./system/packages.nix
	./system/security.nix
    ];
    user = mkAttrsFromPaths [
	./user/bspwm.nix
	./user/dunst.nix
	./user/git.nix
	./user/gpg.nix
	# ./user/emacs.nix
	./user/neovim-minimal.nix
	./user/packages-keksbg.nix
	./user/polybar.nix
	./user/theming.nix
	./user/sessionVariables.nix
	./user/sxhkd.nix
	./user/xdg.nix
	./user/xorg.nix
	./user/zsh.nix
    ];
}
