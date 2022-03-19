{ config, ... }: {
    networking = {
        useDHCP = false;
        interfaces.enp0s31f6.useDHCP = true;
        nameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
}
