{ config, pkgs, lib, ... }:

let
	shellConfigs = ./configs/shell;

	gitScripts = pkgs.runCommand "git-scripts" {} ''
		mkdir -p $out/bin
		cp -r ${shellConfigs}/git/local/* $out/bin/
		chmod +x $out/bin/*
	'';
in
{
#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		tmux
		ranger
		htop
		chafa
		poppler-utils
		foot
		git
		gitScripts
	];

	programs.zsh = {
		enable  = true;
		dotDir = "${config.xdg.configHome}/zsh";
	};

#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {
		".config/git/" = {
			source = "${shellConfigs}/git/config";
			recursive = true;
		};

		".config/zsh/" = {
			source = "${shellConfigs}/zsh/";
			recursive = true;
		};

		".config/tmux/" = {
			source = "${shellConfigs}/tmux/";
			recursive = true;
		};

		".config/foot/" = {
			source = "${shellConfigs}/foot/";
			recursive = true;
		};

		".config/ranger/" = {
			source = "${shellConfigs}/ranger/";
			recursive = true;
		};

		".config/htop/" = {
			source = "${shellConfigs}/htop/";
			recursive = true;
		};
	};
}
