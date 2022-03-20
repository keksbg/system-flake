{ fetchFromGitHub, inputs, lib }:
let
  rc = "";
  version = "5.16.16${rc}";
  kernelHash = "13qk6cjnjwgnxj25mphyv08pjf1sqz7bxxrr3fpl8gz3aghdd9yc";
  #kernelPatchHash = "044y7mmla0f73mky24vpvl8ba3warfr6im97s1231gjxican40v6";

  tkgPatches = [
    "0001-mm-Support-soft-dirty-flag-reset-for-VA-range"
    "0002-clear-patches"
    "0002-mm-Support-soft-dirty-flag-read-with-reset"
    "0003-glitched-base"
    "0007-v${mm}-fsync1_via_futex_waitv"
    "0007-v${mm}-winesync"
    "0009-glitched-bmq"
    "0009-glitched-ondemand-bmq"
    "0009-prjc_v${mm}-r0"
    "0012-misc-additions"
  ];

  patch = path: {
    name = "patch-${path}";
    patch = path;
  };
  # kernelPatchSrc = {
  #   name = "patch";
  #   patch = builtins.fetchurl {
  #     url = "https://cdn.kernel.org/pub/linux/kernel/v${lib.versions.major version}.x/patch-${version}.xz";
  #     sha256 = kernelPatchHash;
  #   };
  # };
  mm = lib.versions.majorMinor version;
in {
  inherit version;

  #src = builtins.fetchurl {
  #  url = "https://git.kernel.org/torvalds/t/linux-${version}${rc}.tar.gz";
  #  sha256 = kernelHash;
  #};
  src = builtins.fetchurl {
    url = "https://cdn.kernel.org/pub/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
    sha256 = kernelHash;
  };

  kernelPatches = [
    (patch ./si-manual-clocking.patch)
  ]
  ++ builtins.map (name: {
    inherit name;
    patch = "${inputs.linux-tkg}/linux-tkg-patches/${mm}/${name}.patch";
  }) tkgPatches;

}
