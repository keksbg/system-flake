{ config, ... }:

{
  services.resolved = {
    enable = true;
    dnssec = "true";
    fallbackDns = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
      "8.8.8.8"
      "8.8.4.4"
    ];
    extraConfig = ''
      DNSOverTls=yes
    '';
  };
}
