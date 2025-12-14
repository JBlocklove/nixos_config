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
		zsh
		tmux
	];

#####################################
# any environment vars you need     #
#####################################
## home.sessionVariables = {
##   # if your pass store isn’t at ~/.password-store
##   PASSWORD_STORE_DIR = "$HOME/.local/share/pass";
## };

#################################################
# symlink your real config files into ~/.config #
#################################################
	home.file = {
# zsh
		".config/isync/" = {
			source = "${emailConfigs}/isync/";
			recursive = true;
		};

# tmux
		".config/msmtp/" = {
			source = "${emailConfigs}/msmtp/";
			recursive = true;
		};
	};
}

