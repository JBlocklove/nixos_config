{
    description = "JBlocklove's nixos config flake";

    inputs = {
        ## Core functions
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

        nixpkgs-zotero.url = "github:nixos/nixpkgs/c27cdad491a991b11ed731760aa2ef8db0cb0410";

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

        nix-neovim = {
            url = "github:JBlocklove/nix-neovim";
            # url = "path:/home/jason/repos/nix/nix-neovim";
            flake = true;
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia";
            inputs.nixpkgs.follows = "nixpkgs";
            # flake = true;
        };

        git-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        { self, nixpkgs, ... }@inputs:
        let
            systems = [ "x86_64-linux" ];
            forEachSystem = nixpkgs.lib.genAttrs systems;

            ## Modules that will belong to every machine
            sharedModules = [
                inputs.home-manager.nixosModules.default
                inputs.nix-index-database.nixosModules.default
                ./hosts/common.nix
            ];
        in
        {

            # Git hooks to check formatting, dead files, and antipatterns
            checks = forEachSystem (system: {
                pre-commit-check = inputs.git-hooks.lib.${system}.run {
                    src = ./.;
                    hooks = {
                        # statix.enable = true;
                        nixfmt = {
                            enable = true;
                            settings.indent = 4;
                        };
                        # deadnix = {
                        #     enable = true;
                        #     excludes = [
                        #         "hardware-configuration\\.nix$"
                        #         "empty\\.nix$"
                        #     ];
                        # };
                    };
                };
            });

            devShells = forEachSystem (system: {
                default =
                    let
                        pkgs = nixpkgs.legacyPackages.${system};
                        inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
                    in
                    pkgs.mkShell {
                        inherit shellHook;
                        buildInputs = enabledPackages;
                    };
            });

            formatter = forEachSystem (
                system:
                let
                    pkgs = nixpkgs.legacyPackages.${system};
                    inherit (self.checks.${system}.pre-commit-check.config) package configFile;
                    script = "${pkgs.lib.getExe package} run --all-files --config ${configFile}";
                in
                pkgs.writeShellScriptBin "pre-commit-run" script
            );

            # System configs
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

                ## Jellyfin server
                arnor = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = sharedModules ++ [
                        ./hosts/arnor/configuration.nix
                    ];
                };
            };
        };
}
