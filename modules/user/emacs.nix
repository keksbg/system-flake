{ config, pkgs, ... }: {
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = pkgs.emacs;
  };
}
