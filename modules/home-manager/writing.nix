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
		# neovim
		texliveFull
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


