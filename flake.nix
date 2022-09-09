{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";

    # zsh plugins
    zsh-abbr = { url = "github:olets/zsh-abbr"; flake = false; };
    zsh-history-substring-search = { url = "github:zsh-users/zsh-history-substring-search"; flake = false; };
    fast-syntax-highlighting = { url = "github:zdharma-continuum/fast-syntax-highlighting"; flake = false; };
    pure = { url = "github:sindresorhus/pure"; flake = false; };

    # overlays
    linux-tkg = { url = "github:Frogging-Family/linux-tkg?rev=093d74d417617d7805f22b57ce326ab8357a1661"; flake = false; };
    powercord-overlay.url = "github:LavaDesu/powercord-overlay";
    powercord-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";

    # powercord plugins
    cutecord = { url = "github:powercord-community/cutecord"; flake = false; };
    ghostbuster = { url = "github:powercord-community/ghostbuster"; flake = false; };
    betterfriends = { url = "github:powercord-community/betterfriends"; flake = false; };
    channel-typing = { url = "github:powercord-community/channel-typing"; flake = false; };
  };

  nixConfig = {
    substituters = [ "https://cache.nixos.org" "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      overlays = (import ./overlays)
        ++ [ inputs.powercord-overlay.overlay ]
        ++ [
        (final: prev: {
          me = prev.callPackage ./packages { inherit inputs; } // { inherit inputs; };
        })
      ];

      mkSystem =
        nixpkgs: name: arch: enableGUI: nixpkgs.lib.nixosSystem {
          system = arch;
          modules = [
            { nixpkgs.overlays = overlays; }
            (./hosts + "/${name}")
          ];
          specialArgs = {
            inherit inputs enableGUI;
            modules = import ./modules { lib = nixpkgs.lib; };
          };
        };
    in
    {
      nixosConfigurations."winter" = mkSystem nixpkgs "winter" "x86_64-linux" true;
      nixosConfigurations."betelgeuse" = mkSystem nixpkgs "betelgeuse" "x86_64-linux" true;
      packages."x86_64-linux" =
        let
          pkgs = import nixpkgs {
            inherit overlays;
            system = "x64_64-linux";
          };
        in
        {
          inherit (pkgs.me) linux-lava;
        };
    };

}
