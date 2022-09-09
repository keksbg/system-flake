self: super: {
  discord-canary = (super.discord.override rec {
    version = "0.0.139";
    src = builtins.fetchurl {
      url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
      sha256 = "1llafigs2zd49m212d49zi4klx39kn4r2msxz75cmi4i6p8wxxzw";
    };
    binaryName = "DiscordCanary";
  }).overrideAttrs (oldAttrs: {
    withOpenASAR = true;
  });
}
