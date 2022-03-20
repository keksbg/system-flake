self: super: {
    discord-canary = (super.discord-canary.override rec {
        version = "0.0.134";
        src = builtins.fetchurl {
            url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
            sha256 = "0hynv9nh6lcfy44yxs33686iyzvjrnczxkppb75c6a4wa7m5l8hz";
        };
    }).overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
            cp ${super.fetchurl {
                url = "https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar";
                sha256 = "16wcq82iyaq4cn16b54bgwyrz3956ffjikqdj542kh0h8wrxfvc3";
            }} $out/opt/DiscordCanary/resources/app.asar
        '';
    });
}
