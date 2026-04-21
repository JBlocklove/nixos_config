{ config, pkgs, lib, ... }:
let
	mediaConfigs = ./configs/media;

in {
	#####################
	# install packages  #
	#####################
	home.packages = with pkgs; [
		calibre
		vlc
		unison
		sshfs
	];
}
