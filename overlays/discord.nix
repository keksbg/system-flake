self: super: {
    discord-canary = super.discord-canary.override rec {
        version = "0.0.134";
	src = builtins.fetchurl {
            url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
	};
    };
}
