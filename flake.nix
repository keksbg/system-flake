{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	home-manager.url = "github:nix-community/home-manager";
	nixos-hardware.url = "github:NixOS/nixos-hardware";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";
	nix-gaming.url = "github:fufexan/nix-gaming";

	# overlays
	linux-tkg = { url = "github:FroggingFamily/linux-tkg"; flake = false; };
	powercord-overlay.url = "github:LavaDesu/powercord-overlay";
	powercord-overlay.inputs.nixpkgs.follows = "nixpkgs";
	rust-overlay.url = "github:oxalica/rust-overlay";
    };

    outputs = { self, nixpkgs, ... } @ inputs:
        let overlays = (import ./overlays)
	    ++ [inputs.powercord-overlay.overlay];

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
            nixosConfigurations,"winter" = mkSystem nixpkgs "winter" "x86_64-linux" true;
	    packages."x86_64-linux" = 
	        let
		    pkgs = import nixpkgs {
                        inherit overlays;
			system = "x64_64-linux";
		    };
	        in
		{
                    inherit (pkgs.me) linux-lava;
		}
	}

}
