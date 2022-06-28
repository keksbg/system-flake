self: super: {
  discord = (super.discord.override rec {
    version = "0.0.135";
    src = builtins.fetchurl {
      url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
      sha256 = "19ri82pwz43wma9kyy2109wdbrmq2zxy2bq03l3i7m4j2pfbwqbn";
    };
  }).overrideAttrs (oldAttrs: {
    withOpenASAR = true;
  });
}
