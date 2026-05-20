{ config, pkgs, ... }:

let
    __Configs = ../configs/__;
in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
	];

#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {
		".config/<prog>/" = {
			source = "${__Configs}/<prog>/";
			recursive = true;
		};
	};
}

