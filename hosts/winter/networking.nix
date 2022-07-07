{ config, ... }: {
  networking = {
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp5s0.useDHCP = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    wireless = {
      enable = true;
      scanOnLowSignal = false;
      networks = {
        "Vasil" = {
          psk = "7512248550";
        };
      };
    };
  };
}
