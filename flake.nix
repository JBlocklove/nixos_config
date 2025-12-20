{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		catvim = {
			url = "github:JBlocklove/catvim";
			flake = true;
		};

		hyprdynamicmonitors = {
			url = "github:fiffeek/hyprdynamicmonitors";
			flake = true;
		};

		sops-nix.url = "github:Mic92/sops-nix";

	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};

		in{
			nixosConfigurations.fangorn = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [
					./hosts/fangorn/configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};

			nixosConfigurations.mirkwood = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [
					./hosts/mirkwood/configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};

			homeManagerModules.default = ./modules/home-manager;
		};
	}
