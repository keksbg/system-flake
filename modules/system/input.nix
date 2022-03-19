{ config, lib, pkgs, ... }: {
  services.xserver = {
    displayManager = {
      xserverArgs = [
        "-ardelay 250"
        "-arinterval 15"
      ];
    };
    libinput = {
      enable = true;
      mouse = {
        accelSpeed = "1";
        accelProfile = "flat";
      };
    };
    xkbOptions = "caps:escape";
  };
  console.useXkbConfig = true;
}
