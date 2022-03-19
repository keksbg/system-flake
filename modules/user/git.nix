{ config, ... }: {
  programs.git = {
    enable = true;
    userName = "Stella";
    userEmail = "jens300304@gmail.com";
    signing = {
      key = "REPLACEMELATER";
      signByDefault = true;
    };
    extraConfig = {
      core.abbrev = 11;
    };
  };
}
