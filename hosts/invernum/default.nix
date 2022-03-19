{ config, inpouts, modules, overlays, pkgs, ...}: {
    networking.hostName = "winter";
    system.stateVersion = "21.11";
    time.timeZone = "Europe/Sofia";

    # agenix later
    imports = with modules.system; [
        inputs.home-manager.nixosModule
	home-manager

	audio
	base
	greetd
	gui
	input
	kernel
	nix
	packages
	security
	./filesystem.nix
	./kernel.nix
	./networking.nix

	../../users/keksbg
    ];
}
