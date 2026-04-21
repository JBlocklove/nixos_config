{ config, pkgs, inputs, ... }:

{
	imports = [
		inputs.sops-nix.homeManagerModules.sops
		../../modules/home-manager/browser.nix
		../../modules/home-manager/development.nix
		../../modules/home-manager/email.nix
		../../modules/home-manager/media-management.nix
		../../modules/home-manager/music.nix
		../../modules/home-manager/productivity.nix
		../../modules/home-manager/shell.nix
		../../modules/home-manager/wm.nix
		../../modules/home-manager/writing.nix
	];

	home.username = "jason";
	home.homeDirectory = "/home/jason";

	home.stateVersion = "24.11"; # Please read the comment before changing.

	home.packages = [
	];

	home.file = {};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

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

	sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

	programs.home-manager.enable = true;
}
