{ config, pkgs, ... }:

let
	musicConfigs = ./configs/music;
in {

	home.packages = with pkgs; [
		ncmpcpp
		mpc
		picard
		chromaprint
		yt-dlp
		finamp
		playerctl
	];

	sops.secrets = {
		mopidy-config = {
			sopsFile = "${musicConfigs}/mopidy/mopidy.conf";
			format = "binary";
			path = "${config.home.homeDirectory}/.config/mopidy/mopidy_secure.conf";
			mode = "0400";
		};
	};

	home.file = {
		".config/ncmpcpp/" = {
			source = "${musicConfigs}/ncmpcpp/";
			recursive = true;
		};
	};
}
