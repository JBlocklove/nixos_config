{ config, inputs, ... }: {

	imports = [
		inputs.sops-nix.homeManagerModules.sops
		../../modules/home-manager/shell.nix
	];

    # User profile
	home.username = "jason";
	home.homeDirectory = "/home/jason";
	home.stateVersion = "25.11";

    # User environment
	home.sessionVariables = {
		EDITOR = "nvim";
        NH_FLAKE = "${config.home.homeDirectory}/nixos"; # points nh to ~/nixos
	};

    # Enforce custom XDG directories
	xdg = {
		enable = true;
		userDirs = {
			enable = true;
			setSessionVariables = true;
			desktop = "${config.home.homeDirectory}/documents";
			documents = "${config.home.homeDirectory}/documents";
			download = "${config.home.homeDirectory}/downloads";
		};
	};

    # Secrets management
	sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    # Home-manager manages itself
	programs.home-manager.enable = true;
}
