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
		yazi
		yaziPlugins.git
		#yaziPlugins.glow
		#yaziPlugins.piper
	];

#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {
		".config/yazi/" = {
			source = "${termConfigs}/yazi/";
			recursive = true;
		};
	};
}

