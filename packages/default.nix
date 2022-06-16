{ callPackage
, inputs
}: rec {
  dwarfs = callPackage ./dwarfs.nix { };
  linux-lava = callPackage ./linux-lava { inherit inputs; };
  tetrio-desktop = callPackage ./tetrio/base.nix { };
  tetrio-desktop-plus = callPackage ./tetrio/plus.nix { inherit tetrio-desktop; };
}
