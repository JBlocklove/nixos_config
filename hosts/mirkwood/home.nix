{ config, inputs, ... }: {

	imports = [
		inputs.sops-nix.homeManagerModules.sops
		../../modules/home-manager/wm.nix
		../../modules/home-manager/gui-term.nix
		../../modules/home-manager/shell.nix
		../../modules/home-manager/pim.nix
		../../modules/home-manager/browser.nix
		../../modules/home-manager/writing.nix
		../../modules/home-manager/communication/chat.nix
		../../modules/home-manager/communication/email.nix
		../../modules/home-manager/media/media-management.nix
		../../modules/home-manager/media/music.nix
		../../modules/home-manager/engineering/ece.nix
		../../modules/home-manager/engineering/development.nix
		../../modules/home-manager/engineering/3d.nix
		../../modules/home-manager/capture.nix
	];

    # User profile
	home.username = "jason";
	home.homeDirectory = "/home/jason";
	home.stateVersion = "24.11";

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
