{ config, inputs, modules, overlays, pkgs, ... }: {
  networking.hostName = "winter";
  networking.hostId = "e7531249";
  system.stateVersion = "21.11";
  time.timeZone = "Europe/Sofia";

  # agenix later
  imports = with modules.system; [
    inputs.home-manager.nixosModule
    home-manager

    audio
    base
    gui
    kernel
    nix
    packages
    security
    sway

    ./filesystem.nix
    ./kernel.nix
    ./networking.nix
    ./btrfs.nix

    ../../users/keksbg
  ];
}
