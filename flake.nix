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

		bannerVim = {
			# url = "github:JBlocklove/bannerVim";
			url = "path:/home/jason/repos/bannerVim";
			flake = true;
		};

		hyprdynamicmonitors = {
			url = "github:fiffeek/hyprdynamicmonitors";
			flake = true;
		};

		sops-nix.url = "github:Mic92/sops-nix";

		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		noctalia = {
			url = "github:JBlocklove/noctalia-shell";
			inputs.nixpkgs.follows = "nixpkgs";
		};

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
					inputs.nix-index-database.nixosModules.default
				];
			};

			nixosConfigurations.mirkwood = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [
					./hosts/mirkwood/configuration.nix
					inputs.home-manager.nixosModules.default
					inputs.nix-index-database.nixosModules.default
					inputs.noctalia.nixosModules.default
				];
			};

			homeManagerModules.default = ./modules/home-manager;
		};
	}
