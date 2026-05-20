{ config, pkgs, ... }:

let
	musicConfigs = ./configs/music;
in {

    #####################
    # install packages  #
    #####################
	home.packages = with pkgs; [
		picard
		chromaprint
		yt-dlp
		finamp
		playerctl
	];
}
