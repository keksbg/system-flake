{ config, ... }: {
  programs.git = {
    enable = true;
    userName = "Stella";
    userEmail = "jens300304@gmail.com";
    signing = {
      key = "3407C727615FE1ED";
      signByDefault = true;
    };
    extraConfig = {
      core.abbrev = 11;
    };
  };
}
