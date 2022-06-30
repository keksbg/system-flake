{ config, ... }: {
  programs.git = {
    enable = true;
    userName = "Stella";
    userEmail = "stellarinfinity@riseup.net";
    signing = {
      key = "3D6DCA5B6F2C2A7A";
      signByDefault = true;
    };
    extraConfig = {
      core.abbrev = 11;
    };
  };
}
