{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
termConfigs = ./configs/terminal;
in
{
#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		texliveFull
		zathura
	];

#######################################
# symlink config files into ~/.config #
#######################################
	#home.file = {
	#	".config/yazi/" = {
	#		source = "${termConfigs}/yazi/";
	#		recursive = true;
	#	};
	#};
}


