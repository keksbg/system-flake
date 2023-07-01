{ lib }:
let
  getName = path: lib.removeSuffix ".nix" (
    lib.last (
      lib.splitString "/" (
        builtins.toString path
      )
    )
  );
  mkAttrsFromPaths = paths: builtins.listToAttrs (
    builtins.map
      (path: {
        name = getName path;
        value = path;
      })
      paths
  );
in
{
  system = mkAttrsFromPaths [
    ./system/base.nix
    ./system/gui.nix
    ./system/home-manager.nix
    ./system/input.nix
    ./system/kernel.nix
    ./system/network.nix
    ./system/nix.nix
    ./system/packages.nix
    ./system/security.nix
    ./system/sway.nix
  ];
  user = mkAttrsFromPaths [
    ./user/direnv.nix
    ./user/dunst.nix
    ./user/emacs.nix
    ./user/git.nix
    ./user/gpg.nix
    ./user/neovim-minimal.nix
    ./user/sessionVariables.nix
    ./user/theming.nix
    ./user/xdg.nix
    ./user/zsh.nix
  ];
}
