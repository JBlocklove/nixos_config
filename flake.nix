{
    description = "JBlocklove's nixos config flake";

    inputs = {
        ## Core functions
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        ## System-level additions
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        ## User-space tools
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprdynamicmonitors = {
            url = "github:fiffeek/hyprdynamicmonitors";
            flake = true;
        };

        nix-neovim = {
            url = "github:JBlocklove/nix-neovim";
            # url = "path:/home/jason/repos/nix/nix-neovim";
            flake = true;
        };
    };

    outputs = { self, nixpkgs, ... }@inputs:
        let
            ## Modules that will belong to every machine 
            sharedModules = [
                inputs.home-manager.nixosModules.default
                inputs.nix-index-database.nixosModules.default
            ];
        in {
            nixosConfigurations = {
                ## Home desktop
                fangorn = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = sharedModules ++ [
                        ./hosts/fangorn/configuration.nix
                    ];
                };

                ## Main laptop
                mirkwood = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = sharedModules ++ [
                        ./hosts/mirkwood/configuration.nix
                    ];
                };
            };

            # Expose home-manager modules externally if needed
            homeManagerModules.default = ./modules/home-manager;
        };
}
