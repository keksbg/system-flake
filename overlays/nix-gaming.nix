self: super: {
    osu-lazer-bin = super.inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin.override rec {
        pipewire_latency = "64/48000";
    };
}
