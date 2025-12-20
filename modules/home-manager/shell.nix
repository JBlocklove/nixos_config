{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
shellConfigs = ./configs/shell;
in
{
#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		tmux
	];

	programs.zsh = {
		enable  = true;
		# enableCompletion = true;
		# autosuggestion.enable = true;
		# syntaxHighlighting.enable = true;
	};

######################################
# any environment vars you need     #
######################################
	home.sessionVariables = {
		ZDOTDIR = "$HOME/.config/zsh";
	};

#################################################
# symlink your real config files into ~/.config #
#################################################
	home.file = {
		".config/zsh/" = {
			source = "${shellConfigs}/zsh/";
			recursive = true;
		};

		".config/tmux/" = {
			source = "${shellConfigs}/tmux/";
			recursive = true;
		};

	};
}
