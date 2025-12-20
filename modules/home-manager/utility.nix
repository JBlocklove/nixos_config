{ config, pkgs, lib, ... }:

let
	utilConfigs = ./configs/utility;
	localBin = pkgs.symlinkJoin {
		name = "local-bin";
		paths = [
			"${utilConfigs}/rofi/local"
			"${utilConfigs}/dunst/local"
			"${utilConfigs}/git/local"
		];
	};
in
{
#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		alacritty
		rofi
		dunst
		git
	];

############################################
# symlink real config files into ~/.config #
############################################
	home.file = {
		".config/alacritty/" = {
			source = "${utilConfigs}/alacritty/";
			recursive = true;
		};

		".config/rofi/" = {
			source = "${utilConfigs}/rofi/config";
			recursive = true;
		};

		".config/dunst/" = {
			source = "${utilConfigs}/dunst/config";
			recursive = true;
		};

		".config/git/" = {
			source = "${utilConfigs}/git/config";
			recursive = true;
		};

		# Executable linking
		".local/bin/" = {
			source = localBin;
			recursive = true;
		};
	};
}

