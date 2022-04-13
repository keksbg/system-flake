{ config, inputs, modules, overlays, pkgs, ... }: {
  networking.hostName = "betelgeuse";
  networking.hostId = "b97e8028";
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Rome";

  # agenix later
  imports = with modules.system; [
    inputs.home-manager.nixosModule
    home-manager

    audio
    base
    gui
    input
    kernel
    nix
    packages
    security
    ./filesystem.nix
    ./kernel.nix
    ./networking.nix
    ./zfs.nix

    ../../users/keksbg
  ];
}
