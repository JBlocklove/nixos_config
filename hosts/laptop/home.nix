{ config, pkgs, inputs, ... }:

{

	imports = [
		../../modules/home-manager/firefox.nix
		../../modules/home-manager/email.nix
		../../modules/home-manager/music.nix
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

	xdg.userDirs = {
		enable = true;
		extraConfig = {
			XDG_DOWNLOAD_DIR =  "${config.home.homeDirectory}/downloads";
		};
	};

	programs.home-manager.enable = true;
}
