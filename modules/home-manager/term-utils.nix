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
		handlr-regex
		mimeo
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

	home.file = {
		".config/handlr/" = {
			source = "${termConfigs}/handlr/";
			recursive = true;
		};
	};

	home.file = {
		".config/mimeo/" = {
			source = "${termConfigs}/mimeo/";
			recursive = true;
		};
	};
}

