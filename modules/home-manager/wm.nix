{ config, pkgs, ... }:

let
	wmConfigs = ./configs/wm;

	rofiScripts = pkgs.runCommand "rofi-scripts" {} ''
		mkdir -p $out/bin
		cp -r ${wmConfigs}/rofi/local/* $out/bin/
		chmod +x $out/bin/*
	'';

in {

	home.packages = with pkgs; [
		# hyprland
		rofi
		rofiScripts
		
	];

	home.file = {
		# ".config/hypr/" = {
		# 	source = "${wmConfigs}/hypr/";
		# 	recursive = true;
		# };
		#
		".config/rofi/" = {
			source = "${wmConfigs}/rofi/config";
			recursive = true;
		};
	};
}

