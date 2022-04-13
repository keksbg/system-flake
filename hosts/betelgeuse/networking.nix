{ config, ... }: {
  networking = {
    useDHCP = false;
    interfaces.enp5s0.useDHCP = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}
