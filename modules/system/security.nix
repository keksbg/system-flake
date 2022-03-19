{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = "yes";
    forwardX11 = true;

    hostKeys = [
      {
        bits = 4096;
        path = "/var/persist/ssh_host_rsa_key";
        rounds = 100;
        type = "rsa";
      }
      {
        path = "/var/persist/ssh_host_ed25519_key";
        rounds = 100;
        type = "ed25519";
      }
    ];
  };

  security = {
    polkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
